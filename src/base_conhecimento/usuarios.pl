:- module(base_conhecimento_usuarios, [usuario/2, gosta/2]).

usuario(joao, 'João').
usuario(ana, 'Ana').
usuario(mariana, 'Mariana').
usuario(carlos, 'Carlos').

gosta(joao, fantasia).
gosta(joao, ficcao_cientifica).

gosta(ana, romance).
gosta(ana, suspense).

gosta(mariana, infantil).
gosta(mariana, fantasia).

gosta(carlos, historia).
gosta(carlos, biografia).
