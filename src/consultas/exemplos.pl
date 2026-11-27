% Consultas de demonstracao da issue #10.
% Carregue a partir da raiz: ?- consult('src/consultas/exemplos.pl').
% Copie cada consulta (sem o prefixo ?-) no terminal do SWI-Prolog.
% Resultados abaixo sao esperados para a base de 27/11/2026;
% consulte docs/testes.md para o status da execucao.

:- use_module('../recomendador').

% 1. Inferencia positiva: identificador e titulo de um livro.
% ?- recomendar(ana, dom_casmurro, Titulo).
% Esperado: Titulo = 'Dom Casmurro'.

% 2. Enumerar recomendacoes de Ana; use ; para obter a proxima resposta.
% ?- recomendar(ana, IdLivro, Titulo).
% Esperado: 10 livros distintos (romance ou suspense).

% 3. Consolidar os resultados de Joao, com duas preferencias.
% ?- findall(Id-Titulo, recomendar(joao, Id, Titulo), Livros),
%    length(Livros, Total).
% Esperado: Total = 14.

% 4. Explicar a inferencia: preferencias de Mariana e generos de Harry Potter.
% ?- gosta(mariana, G), genero_livro(harry_potter_pedra_filosofal, G).
% Esperado: infantil e fantasia, em qualquer ordem.
% ?- findall(Titulo, recomendar(mariana, harry_potter_pedra_filosofal, Titulo), Titulos).
% Esperado: Titulos = ['Harry Potter e a Pedra Filosofal'] (uma unica vez).

% 5. Livro conhecido, mas sem genero compativel com Ana.
% ?- recomendar(ana, o_hobbit).
% Esperado: false.

% 6. Usuario inexistente.
% ?- recomendar(usuario_inexistente_teste, IdLivro, Titulo).
% Esperado: false.
% ?- findall(Id, recomendar(usuario_inexistente_teste, Id), Livros).
% Esperado: Livros = [].

% 7. Carlos: historia ou biografia.
% ?- findall(Id, recomendar(carlos, Id), Livros), length(Livros, Total).
% Esperado: Total = 12.

% 8. Verificar a disponibilidade dos cenarios de borda na base real.
% ?- usuario(U, _), findall(G, gosta(U, G), Gs), sort(Gs, [_]).
% Esperado na base de 27/11/2026: false (nenhum usuario com uma preferencia).
% ?- usuario(U, _), \+ gosta(U, _).
% Esperado na base de 27/11/2026: false (nenhum usuario sem preferencias).
% ?- usuario(U, _), once(gosta(U, _)),
%    \+ (gosta(U, G), genero_livro(L, G), livro(L, _)).
% Esperado na base de 27/11/2026: false (todos possuem livros compativeis).
