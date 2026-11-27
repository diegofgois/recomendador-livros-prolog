# Validação de recomendações — issue #10

Responsável: Thiago — consultas e testes.  
Referência analisada: `main` no commit `7a2b7f4008cf0d354dc26177c5de3c318d5bf1d3` (27/11/2026).

## Objetivo e método

Conferir a API `recomendar/2` e `recomendar/3` contra os fatos cadastrados e o contrato da arquitetura. A revisão estática cruzou identificadores dos livros, relações de gênero e preferências dos usuários, sem executar a regra Prolog. As listas esperadas são independentes da implementação da regra e foram transcritas para as asserções PlUnit; não são novos fatos da base. A ordem das respostas não é requisito, mas duplicatas são erros.

## Resultados esperados a partir dos fatos

| Usuário | Preferências | Livros distintos esperados | Exemplo |
| --- | --- | ---: | --- |
| João (`joao`) | fantasia, ficcao_cientifica | 14 | O Hobbit, Duna |
| Ana (`ana`) | romance, suspense | 10 | Dom Casmurro, O Código Da Vinci |
| Mariana (`mariana`) | infantil, fantasia | 11 | Matilda, O Hobbit |
| Carlos (`carlos`) | historia, biografia | 12 | Sapiens, Steve Jobs |

Base analisada: 50 livros, 10 gêneros, 4 usuários e 2 preferências para cada usuário. Mariana tem 5 livros com dois gêneros compatíveis e Carlos tem 1; cada livro deve aparecer apenas uma vez por usuário. As listas completas de IDs esperados constam em `tests/recomendacoes_tests.pl`.

## Cenários e estado da validação provisória

| Cenário | Resultado esperado | Resultado observado em 27/11/2026 |
| --- | --- | --- |
| Quatro usuários válidos com múltiplas preferências | Conjuntos exatos de 14, 10, 11, 12 IDs | Conjuntos exatos confirmados pelo PlUnit |
| Título de livro conhecido | Ana + dom_casmurro retorna 'Dom Casmurro' | Confirmado pelo PlUnit |
| Consistência das aridades 2 e 3 | Mesmos IDs; título corresponde ao cadastro | Confirmado pelo PlUnit |
| Livro com dois gêneros compatíveis | Harry Potter retorna uma única vez para Mariana | Confirmado pelo PlUnit; um título retornado |
| Livro conhecido incompatível | Ana + o_hobbit retorna false | Confirmado pelo PlUnit |
| Usuário inexistente | false em ambas as aridades | Confirmado pelo PlUnit |
| Livro inexistente | false | Confirmado pelo PlUnit |
| Usuário com uma preferência e livros compatíveis | Somente livros desse gênero | Ausente na base real; aprovado com perfil sintético isolado |
| Usuário cadastrado sem preferência | false em ambas as aridades | Ausente na base real; aprovado com perfil sintético isolado |
| Usuário com preferência sem livro compatível | false em ambas as aridades | Ausente na base real; aprovado com gênero sintético sem livros |

A suíte possui 15 casos declarados, dos quais 3 são condicionais. Na base real, 12 passaram e 3 não foram executados por falta de perfis. Os três cenários foram exercitados separadamente com dados sintéticos apenas na cópia descartável do GitHub Actions. Não há novos fatos nos arquivos versionados da base. Nenhuma divergência de recomendação foi observada nas execuções provisórias. Os perfis reais, caso necessários à apresentação, devem ser alinhados com Pedro e Diego.

## Como executar (após integração da issue #11)

Na raiz do repositório, em ambiente com SWI-Prolog:

```bash
swipl -q -s tests/recomendacoes_tests.pl -g run_tests -t halt
```

Para a demonstração interativa, iniciar o SWI-Prolog e executar:

```prolog
?- consult('src/consultas/exemplos.pl').
?- recomendar(ana, IdLivro, Titulo).
?- findall(Id, recomendar(joao, Id), Livros), length(Livros, Total).
?- findall(T, recomendar(mariana, harry_potter_pedra_filosofal, T), Ts).
?- recomendar(ana, o_hobbit).
?- recomendar(usuario_inexistente_teste, _, _).
```

Resultados esperados: 10 soluções para Ana, total de 14 para João, um único título de Harry Potter, e `false` nas duas consultas negativas. Usar `;` para pedir novas soluções quando aplicável.

## Evidências de execução online — 27/11/2026

Ambiente: GitHub Actions, SWI-Prolog 9.2.9, Linux. Branch de validação isolada `test/issue-10-validacao-online`, fora da PR #16. Como `src/recomendador.pl` ainda não existe na main, o runner gerou temporariamente o ponto de entrada exatamente conforme `docs/arquitetura.md`, sem commit desse arquivo. A validação não substitui a integração oficial da issue #11.

- [Execução inicial](https://github.com/diegofgois/recomendador-livros-prolog/actions/runs/46062537249): quantidades e Harry Potter confirmados; falha na sintaxe de uma consulta auxiliar do workflow (`\\+/3`), corrigida na execução seguinte. A suíte não chegou a rodar nesse primeiro run.
- [Validação da base real](https://github.com/diegofgois/recomendador-livros-prolog/actions/runs/46062607239): `All 12 tests passed`; 3 casos condicionais ausentes; os perfis consultados retornaram `[]` para os três grupos.
- [Validação com cenários sintéticos](https://github.com/diegofgois/recomendador-livros-prolog/actions/runs/46062639164): base real com 12 testes aprovados e, em seguida, base temporária com 15 testes aprovados. Um usuário com uma preferência (romance) recebeu 5 livros, e os dois usuários sem correspondências receberam listas vazias. Os dados sintéticos foram adicionados apenas ao workspace descartável do runner, nunca à main ou à PR #16. Um aviso de variável singleton no teste foi corrigido nas branches de entrega e validação.

## Pendências para conclusão

- Diego: entregar `src/recomendador.pl` na issue #11; repetir a suíte com o ponto de entrada oficial, sem gerar um substituto no runner.
- Pedro/Diego: decidir se os três perfis de borda precisam existir na base definitiva para demonstração. Já foram exercitados com dados sintéticos isolados; a base real segue sem eles.
- Registrar a execução integrada final e repassar a Rafael os resultados com a distinção entre base real e sintética.
- Manter a issue aberta até a integração oficial e a revisão do grupo.
