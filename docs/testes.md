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

## Cenários e estado da validação

| Cenário | Resultado esperado | Resultado observado em 27/11/2026 |
| --- | --- | --- |
| Quatro usuários válidos com múltiplas preferências | Conjuntos exatos de 14, 10, 11, 12 IDs | Conferência dos fatos realizada; execução SWI pendente |
| Título de livro conhecido | Ana + dom_casmurro retorna 'Dom Casmurro' | Conferência estática; execução pendente |
| Consistência das aridades 2 e 3 | Mesmos IDs; título corresponde ao cadastro | Contrato e regra revisados; execução pendente |
| Livro com dois gêneros compatíveis | Harry Potter retorna uma única vez para Mariana | Sobreposição confirmada nos fatos; execução pendente |
| Livro conhecido incompatível | Ana + o_hobbit retorna false | Incompatibilidade confirmada nos fatos; execução pendente |
| Usuário inexistente | false em ambas as aridades | ID de teste ausente; execução pendente |
| Livro inexistente | false | ID de teste ausente; execução pendente |
| Usuário com uma preferência e livros compatíveis | Somente livros desse gênero | Bloqueado: não existe perfil na base atual |
| Usuário cadastrado sem preferência | false em ambas as aridades | Bloqueado: não existe perfil na base atual |
| Usuário com preferência sem livro compatível | false em ambas as aridades | Bloqueado: todos os usuários têm correspondências |

A suíte possui 15 casos declarados, dos quais 3 são condicionais aos dados reais. Os condicionais não contam como aprovados se a condição não for satisfeita. A base não será alterada por esta issue; alinhar os perfis faltantes com Pedro e Diego. Pablo deve ser informado sobre eventuais divergências nas recomendações. Não foram identificadas divergências na inspeção estática da regra em relação ao contrato; isso não substitui a execução.

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

## Pendências para conclusão

- Diego: entregar `src/recomendador.pl` na issue #11. A carga integrada não é possível na revisão de referência, pois esse arquivo ainda não existe.
- Pedro/Diego: alinhar os três perfis de borda ausentes, sem duplicar fatos nos testes.
- Executar a suíte em SWI-Prolog, registrar a versão/commit, saída real, casos ignorados e eventuais falhas; repetir após integração.
- Entregar a Rafael os resultados efetivamente executados para a apresentação. Nenhum resultado SWI-Prolog desta issue está sendo declarado como aprovado nesta revisão estática.
