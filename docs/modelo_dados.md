# Modelo de dados da base de conhecimento

Este documento complementa [Arquitetura e contrato entre módulos](arquitetura.md). Os exemplos são dados fictícios para demonstrar o padrão.

## Entidades e relacionamentos

- **Livro:** identificado por `IdLivro`, possui título.
- **Autor:** identificado por `IdAutor`, possui nome.
- **Gênero:** identificado por `IdGenero`, possui nome.
- **Usuário:** identificado por `IdUsuario`, possui nome.
- **Autoria:** relaciona um livro a um autor.
- **Classificação:** relaciona um livro a um ou mais gêneros.
- **Preferência:** relaciona um usuário a um ou mais gêneros de interesse.

## Predicados e argumentos

| Predicado | Argumento 1 | Argumento 2 |
| --- | --- | --- |
| `livro/2` | ID do livro | Título |
| `autor/2` | ID do autor | Nome |
| `escrito_por/2` | ID do livro | ID do autor |
| `genero/2` | ID do gênero | Nome |
| `genero_livro/2` | ID do livro | ID do gênero |
| `usuario/2` | ID do usuário | Nome |
| `gosta/2` | ID do usuário | ID do gênero |

## Exemplo integrado

Os fatos abaixo, distribuídos nos arquivos responsáveis, devem permitir a seguinte inferência:

```prolog
livro(o_hobbit, 'O Hobbit').
autor(j_r_r_tolkien, 'J. R. R. Tolkien').
escrito_por(o_hobbit, j_r_r_tolkien).
genero(fantasia, 'Fantasia').
genero_livro(o_hobbit, fantasia).
usuario(ana, 'Ana').
gosta(ana, fantasia).
```

Consulta esperada:

```prolog
?- recomendar(ana, o_hobbit).
true.
```

O exemplo é conceitual: na implementação real, cada fato fica apenas no arquivo designado e o predicado `recomendar/2` fica no módulo de regras.

## Decisões para a primeira versão

- Um livro terá um identificador único.
- Um autor terá um identificador único.
- Um livro poderá ter um ou mais gêneros.
- Um usuário poderá gostar de um ou mais gêneros.
- Para manter o escopo inicial controlado, cada livro terá um autor principal. Coautoria pode ser adicionada depois, se o grupo decidir.
- A recomendação será baseada em correspondência de gênero. Não haverá pontuação, ranking, aprendizado de máquina ou recomendação por popularidade na primeira versão.
