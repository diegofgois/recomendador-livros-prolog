# Recomendador de Livros com PROLOG

Projeto acadêmico desenvolvido para a disciplina **Matemática Computacional Aplicada**, do curso de Análise e Desenvolvimento de Sistemas.

O objetivo é construir um sistema de recomendação de livros baseado nos gêneros literários de interesse dos usuários, utilizando programação lógica com **PROLOG** e o ambiente **SWI-Prolog**.

> **Status:** planejamento e desenvolvimento inicial. As funcionalidades descritas neste README representam o escopo planejado e poderão ser ajustadas durante a implementação.

## Visão geral

O sistema terá uma base de conhecimentos composta por fatos e regras. Os fatos representarão os livros cadastrados, seus autores, gêneros e preferências dos usuários. As regras utilizarão essas informações para encontrar livros compatíveis com os interesses informados.

A recomendação será obtida por inferência lógica: em vez de cadastrar antecipadamente uma recomendação para cada pessoa, o PROLOG deverá relacionar as preferências do usuário aos gêneros dos livros e retornar os títulos que atenderem aos critérios definidos.

### Objetivos

- Construir uma base de conhecimentos sobre livros, autores, gêneros e usuários.
- Representar informações por meio de fatos e relacionamentos.
- Definir regras lógicas para identificar livros compatíveis com as preferências.
- Realizar consultas e demonstrar as inferências produzidas pelo PROLOG.
- Testar o comportamento do sistema com diferentes usuários e combinações de gêneros.

## Escopo funcional planejado

A primeira versão deverá contemplar:

1. **Cadastro lógico de livros:** identificação dos títulos e de seus autores.
2. **Classificação por gênero:** associação de um ou mais gêneros a cada livro.
3. **Preferências dos usuários:** registro dos gêneros de interesse de cada usuário.
4. **Recomendação:** identificação dos livros cujo gênero corresponda às preferências do usuário.
5. **Consultas:** perguntas à base para localizar livros por gênero, autor ou usuário.
6. **Demonstração de inferências:** apresentação de exemplos em que o PROLOG obtém recomendações a partir da combinação de fatos e regras.

Como possibilidade de extensão, poderão ser avaliados recursos como histórico de leitura para evitar recomendações repetidas e consultas por autor. Esses recursos não são considerados obrigatórios para a primeira versão até que o grupo confirme o escopo.

## Tecnologias e ferramentas

- **PROLOG:** linguagem de programação lógica utilizada para representar fatos, regras e consultas.
- **SWI-Prolog:** ambiente para desenvolver e executar o programa.
- **Git e GitHub:** versionamento, colaboração e disponibilização do código-fonte.

Site oficial: [SWI-Prolog](https://www.swi-prolog.org/).

## Como o sistema deverá funcionar

A base de conhecimentos será organizada em três partes principais:

| Elemento | Aplicação no projeto |
| --- | --- |
| Fatos | Informações sobre livros, autores, gêneros e preferências dos usuários. |
| Regras | Condições que relacionam os gêneros de interesse aos gêneros dos livros. |
| Consultas | Perguntas feitas ao PROLOG para recuperar informações e solicitar recomendações. |

### Exemplo conceitual

Os trechos abaixo ilustram a lógica planejada. São exemplos didáticos, não representam necessariamente a versão final do código.

**Fatos:**

```prolog
gosta(joao, fantasia).
genero(harry_potter, fantasia).
genero(o_hobbit, fantasia).
genero(it_a_coisa, terror).
```

**Regra de recomendação:**

```prolog
recomendar(Usuario, Livro) :-
    gosta(Usuario, Genero),
    genero(Livro, Genero).
```

**Consulta:**

```prolog
?- recomendar(joao, Livro).
```

A partir desses fatos e da regra, o PROLOG poderá encontrar `harry_potter` e `o_hobbit` como respostas para João. Essa conclusão é uma **inferência**, pois não é necessário cadastrar diretamente cada recomendação.

## O que será entregue

O grupo planeja organizar as entregas previstas para o trabalho da seguinte forma:

- **Código-fonte PROLOG:** base de conhecimentos com fatos, regras e consultas necessárias à demonstração do sistema.
- **Repositório no GitHub:** código organizado e disponibilizado neste repositório.
- **Demonstração do sistema:** execução no SWI-Prolog, com exemplos de consultas e inferências.
- **Resumo expandido:** texto acadêmico apresentando o tema, objetivo, desenvolvimento e resultados do projeto, conforme as orientações do professor e da atividade vinculada à Concitec.
- **Relatório em PDF:** identificação dos integrantes e respectivos RAs, descrição das atividades realizadas por cada membro e endereço do repositório.
- **Apresentação:** exposição do problema, da solução proposta, da modelagem lógica e da demonstração prática.

A apresentação está planejada para **02/12/2026**, conforme a data informada pelo grupo. Caso solicitado, o grupo também deverá estar preparado para apresentar o projeto na Expo Unifacs 2026.2.

> Formatação, modelo e demais exigências específicas do resumo expandido e do relatório deverão seguir as orientações oficiais do professor.

## Planejamento e divisão de responsabilidades

A divisão abaixo organiza as responsabilidades principais entre os seis integrantes. As atividades são complementares: todos devem compreender a lógica geral do sistema, revisar o trabalho em conjunto e participar da apresentação.

| Integrante | Responsabilidade principal | Atividades |
| --- | --- | --- |
| **Diego** | Coordenação e integração | Organizar o cronograma, acompanhar as tarefas, integrar os arquivos desenvolvidos pelo grupo e verificar se o escopo está sendo atendido. |
| **Arthur** | Base de livros e autores | Estruturar os fatos referentes aos livros e autores, padronizar os identificadores e organizar os dados da biblioteca. |
| **Pedro** | Gêneros e preferências | Modelar os gêneros literários, associá-los aos livros e estruturar os fatos que representam as preferências dos usuários. |
| **Pablo** | Regras de recomendação | Desenvolver as regras lógicas que relacionam usuários, gêneros e livros, explicando como as recomendações são inferidas. |
| **Thiago** | Consultas e testes | Preparar consultas de demonstração, testar diferentes combinações de preferências e verificar se as respostas correspondem às regras definidas. |
| **Rafael** | Documentação e apresentação | Organizar o README e a documentação do projeto, apoiar a elaboração do resumo expandido e do relatório e estruturar os materiais da apresentação. |

### Etapas do cronograma

| Etapa | Atividades | Responsáveis |
| --- | --- | --- |
| 1. Alinhamento | Estudar os requisitos, definir o escopo e combinar padrões de código e organização. | Todos; coordenação de Diego |
| 2. Modelagem da base | Definir a representação dos livros, autores, gêneros e usuários. | Arthur e Pedro |
| 3. Implementação lógica | Construir as regras de recomendação e as consultas necessárias. | Pablo e Thiago |
| 4. Integração | Reunir os módulos, revisar a consistência dos predicados e executar o sistema integrado. | Diego, com participação de todos |
| 5. Validação | Testar casos de uso, conferir resultados e corrigir problemas. | Thiago e todos os responsáveis pelos módulos |
| 6. Documentação | Finalizar README, resumo expandido e relatório em PDF. | Rafael, com informações fornecidas por todos |
| 7. Preparação da apresentação | Organizar a explicação do problema, dos conceitos de PROLOG e da demonstração prática. | Todos |

**Marco final:** apresentação e demonstração do projeto em 02/12/2026.

As datas intermediárias deverão ser combinadas pelo grupo e registradas conforme a evolução do trabalho.

## Critérios de validação

Antes da apresentação, o grupo deverá verificar se:

- [ ] Os fatos dos livros, autores, gêneros e usuários estão organizados e consistentes.
- [ ] Cada livro pode estar associado a um ou mais gêneros, quando aplicável.
- [ ] As regras retornam livros compatíveis com as preferências cadastradas.
- [ ] Consultas com diferentes usuários produzem resultados coerentes.
- [ ] O grupo consegue explicar a diferença entre fatos, regras, consultas e inferências.
- [ ] O projeto executa corretamente no SWI-Prolog.
- [ ] O código e os documentos previstos estão disponíveis no repositório.

## Organização do repositório

Estrutura inicial sugerida:

```text
recomendador-livros-prolog/
├── README.md
├── src/
│   └── sistema_recomendacao.pl
├── docs/
│   ├── resumo-expandido.pdf
│   └── relatorio.pdf
└── apresentacao/
    └── slides.pdf
```

A estrutura poderá ser adaptada conforme os arquivos e as necessidades reais do projeto.

## Equipe

- Diego
- Arthur
- Pedro
- Pablo
- Thiago
- Rafael

---

Projeto acadêmico de **Matemática Computacional Aplicada** — Análise e Desenvolvimento de Sistemas.
