:- module(regras_recomendacoes, [recomendar/2, recomendar/3]).

:- use_module('../base_conhecimento/livros', [livro/2]).
:- use_module('../base_conhecimento/generos', [genero_livro/2]).
:- use_module('../base_conhecimento/usuarios', [usuario/2, gosta/2]).

% Recomenda um livro cadastrado quando pelo menos uma preferência do
% usuário corresponde a um dos gêneros associados ao livro.
%
% once/1 limita a busca a uma correspondência por livro, evitando que
% o mesmo identificador seja retornado novamente por outra preferência.
recomendar(IdUsuario, IdLivro) :-
    usuario(IdUsuario, _),
    livro(IdLivro, _),
    once((
        gosta(IdUsuario, IdGenero),
        genero_livro(IdLivro, IdGenero)
    )).

% Versão que também retorna o título cadastrado do livro recomendado.
recomendar(IdUsuario, IdLivro, Titulo) :-
    recomendar(IdUsuario, IdLivro),
    livro(IdLivro, Titulo).
