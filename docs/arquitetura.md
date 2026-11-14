# Arquitetura e contrato entre módulos

Este documento define a estrutura técnica da primeira versão do recomendador. A intenção é permitir que cada integrante implemente seu módulo sem alterar os contratos compartilhados.

## 1. Organização

```text
src/
├── base_conhecimento/
│   ├── livros.pl
│   ├── autores.pl
│   ├── generos.pl
│   └── usuarios.pl
├── regras/
│   └── recomendacoes.pl
├── consultas/
│   └── exemplos.pl
└── recomendador.pl

tests/
└── recomendacoes_tests.pl
```

### Responsabilidade de cada arquivo

| Arquivo | Responsável | Conteúdo |
| --- | --- | --- |
| `base_conhecimento/livros.pl` | Arthur | Identificador e título de cada livro. |
| `base_conhecimento/autores.pl` | Arthur | Autores e relação entre livro e autor. |
| `base_conhecimento/generos.pl` | Pedro | Cadastro de gêneros e relação entre livro e gênero. |
| `base_conhecimento/usuarios.pl` | Pedro | Usuários e preferências de gênero. |
| `regras/recomendacoes.pl` | Pablo | Regras que inferem recomendações a partir dos fatos. |
| `consultas/exemplos.pl` | Thiago | Consultas comentadas para demonstração. |
| `tests/recomendacoes_tests.pl` | Thiago | Testes automatizados com PlUnit. |
| `recomendador.pl` | Diego | Ponto único de entrada e conexão dos módulos. |

Rafael documenta as decisões e os resultados nos arquivos de `docs/`. Diego coordena a integração, mas cada responsável mantém seu próprio módulo.

## 2. Contrato de predicados

Os nomes e as aridades abaixo são o contrato compartilhado. Não altere um nome ou a quantidade de argumentos sem combinar com o grupo.

| Predicado | Significado | Arquivo |
| --- | --- | --- |
| `livro(IdLivro, Titulo)` | Um livro cadastrado. | `livros.pl` |
| `autor(IdAutor, Nome)` | Um autor cadastrado. | `autores.pl` |
| `escrito_por(IdLivro, IdAutor)` | Relaciona um livro ao seu autor. | `autores.pl` |
| `genero(IdGenero, Nome)` | Um gênero cadastrado. | `generos.pl` |
| `genero_livro(IdLivro, IdGenero)` | Relaciona um livro a um gênero. | `generos.pl` |
| `usuario(IdUsuario, Nome)` | Um usuário cadastrado. | `usuarios.pl` |
| `gosta(IdUsuario, IdGenero)` | Registra um gênero de interesse do usuário. | `usuarios.pl` |
| `recomendar(IdUsuario, IdLivro)` | Infere um livro compatível com o usuário. | `recomendacoes.pl` |
| `recomendar(IdUsuario, IdLivro, Titulo)` | Retorna também o título do livro recomendado. | `recomendacoes.pl` |

### Regras para os identificadores

- Identificadores são átomos em `snake_case`, sem espaços ou acentos: `dom_casmurro`, `machado_de_assis`, `ficcao_cientifica`.
- Nomes e títulos exibidos ao usuário são strings entre aspas, preservando acentos: `'Dom Casmurro'`.
- O mesmo livro deve usar exatamente o mesmo `IdLivro` em todos os arquivos.
- O mesmo gênero deve usar exatamente o mesmo `IdGenero` em `generos.pl` e `usuarios.pl`.
- Cada fato deve terminar com ponto.
- Não cadastre a mesma relação duas vezes.
- Um livro pode ter vários fatos `genero_livro/2` se pertencer a mais de um gênero.
- Um usuário pode ter vários fatos `gosta/2` se tiver mais de uma preferência.

## 3. Formato dos fatos

Exemplos ilustrativos; os integrantes podem ampliar o catálogo, mas devem preservar o formato.

`livros.pl`:

```prolog
livro(dom_casmurro, 'Dom Casmurro').
livro(o_hobbit, 'O Hobbit').
```

`autores.pl`:

```prolog
autor(machado_de_assis, 'Machado de Assis').
autor(j_r_r_tolkien, 'J. R. R. Tolkien').

escrito_por(dom_casmurro, machado_de_assis).
escrito_por(o_hobbit, j_r_r_tolkien).
```

`generos.pl`:

```prolog
genero(romance, 'Romance').
genero(fantasia, 'Fantasia').

genero_livro(dom_casmurro, romance).
genero_livro(o_hobbit, fantasia).
```

`usuarios.pl`:

```prolog
usuario(ana, 'Ana').
usuario(bruno, 'Bruno').

gosta(ana, fantasia).
gosta(bruno, romance).
```

## 4. Como os arquivos se conectam

- `recomendacoes.pl` importa os módulos de livros, gêneros e usuários, pois precisa consultar esses fatos para inferir recomendações.
- `recomendador.pl` reexporta os módulos da base e o módulo de regras. Assim, consultas e testes usam um único ponto de entrada.
- `autores.pl` fica disponível pela entrada principal para consultas por autor, mas não é necessário para a regra básica de recomendação por gênero.
- `exemplos.pl` e os testes importam `recomendador.pl`; não devem duplicar fatos nem reimplementar as regras.

A dependência principal é:

```text
livros.pl ───────┐
generos.pl ──────┼──> recomendacoes.pl ──┐
usuarios.pl ─────┘                       │
autores.pl ──────────────────────────────┼──> recomendador.pl
                                        │
consultas/exemplos.pl ──────────────────┤
tests/recomendacoes_tests.pl ───────────┘
```

## 5. Regra de recomendação acordada

A regra deve recomendar um livro quando o usuário existir, o livro estiver cadastrado e houver pelo menos um gênero do livro que corresponda a uma preferência do usuário.

Em termos de predicados:

```prolog
recomendar(Usuario, IdLivro) :-
    usuario(Usuario, _),
    livro(IdLivro, _),
    gosta(Usuario, IdGenero),
    genero_livro(IdLivro, IdGenero).
```

Esse trecho descreve a lógica inicial para Pablo implementar. Se um livro corresponder a mais de uma preferência, a implementação deve evitar apresentar o mesmo livro repetido na demonstração. A forma de tratar isso deve ser validada nos testes.

## 6. Como carregar o projeto

A partir da pasta raiz do repositório, abra o SWI-Prolog e carregue o ponto de entrada:

```prolog
?- use_module('src/recomendador').
```

Depois, faça uma consulta:

```prolog
?- recomendar(ana, IdLivro).
?- recomendar(ana, IdLivro, Titulo).
```

O primeiro argumento é o identificador do usuário. As variáveis começam com letra maiúscula.

## 7. Regras de colaboração

1. Não renomeie predicados nem altere sua aridade sem alinhar com o grupo.
2. Não crie um segundo predicado para representar a mesma relação.
3. Não coloque fatos de livros em `generos.pl` ou preferências em `livros.pl`.
4. Não faça a regra depender de nomes de exibição; use os identificadores.
5. Cada responsável deve testar seu arquivo e avisar Diego quando estiver pronto para integração.
6. Se surgir necessidade de um novo predicado, proponha o nome, a aridade, o significado e o arquivo responsável antes de implementá-lo.
