% Issue #10: testes da API publica de recomendacao.
% A partir da raiz:
% swipl -q -s tests/recomendacoes_tests.pl -g run_tests -t halt

:- begin_tests(recomendacoes).
:- use_module('../src/recomendador').

% Listas de resultados esperados (nao sao fatos da base de conhecimento).
% Comparar listas ordenadas preservando duplicatas e sem depender da ordem
% de enumeracao do Prolog.
confere_ids(Usuario, Esperados) :-
    findall(Id, recomendar(Usuario, Id), Obtidos),
    msort(Obtidos, Ordenados),
    msort(Esperados, Referencia),
    assertion(Ordenados == Referencia).

test(joao_duas_preferencias) :-
    confere_ids(joao, [
        a_historia_sem_fim, alice_no_pais_das_maravilhas,
        as_cronicas_de_narnia_leao_feiticeira_guarda_roupa,
        duna, fahrenheit_451, frankenstein, fundacao,
        harry_potter_pedra_filosofal, neuromancer, o_hobbit,
        o_senhor_dos_aneis, odisseia_2001,
        percy_jackson_ladrao_de_raios, vinte_mil_leguas_submarinas]).

test(ana_duas_preferencias) :-
    confere_ids(ana, [
        a_garota_no_trem, amor_nos_tempos_colera,
        assassinato_no_expresso_oriente, dom_casmurro, grande_gatsby,
        jane_eyre, o_codigo_da_vinci, o_silencio_dos_inocentes,
        orgulho_preconceito, os_homens_que_nao_amavam_as_mulheres]).

test(mariana_duas_preferencias) :-
    confere_ids(mariana, [
        a_historia_sem_fim, alice_no_pais_das_maravilhas,
        as_aventuras_de_tom_sawyer,
        as_cronicas_de_narnia_leao_feiticeira_guarda_roupa,
        harry_potter_pedra_filosofal, matilda, o_hobbit,
        o_menino_do_pijama_listrado, o_pequeno_principe,
        o_senhor_dos_aneis, percy_jackson_ladrao_de_raios]).

test(carlos_duas_preferencias) :-
    confere_ids(carlos, [
        a_era_dos_extremos, armas_germes_e_aco, diarios_de_frida_kahlo,
        holocausto, long_walk_to_freedom, maus, o_diario_de_anne_frank,
        o_menino_do_pijama_listrado, o_principe, sapiens, steve_jobs,
        uma_breve_historia_do_tempo]).

test(titulo_positivo, true(Titulo == 'Dom Casmurro')) :-
    once(recomendar(ana, dom_casmurro, Titulo)).

test(aridades_coerentes_e_titulos_corretos) :-
    forall(usuario(U, _),
        ( findall(Id, recomendar(U, Id), Ids2),
          findall(Id-T, recomendar(U, Id, T), Pares),
          findall(Id, member(Id-_, Pares), Ids3),
          msort(Ids2, Ordenados2),
          msort(Ids3, Ordenados3),
          assertion(Ordenados2 == Ordenados3),
          forall(member(I-Titulo, Pares),
              assertion(livro(I, Titulo)))
        )).

test(sem_duplicatas_para_todos_usuarios) :-
    forall(usuario(U, _),
        ( findall(Id, recomendar(U, Id), Ids),
          msort(Ids, Todos),
          sort(Ids, Unicos),
          assertion(Todos == Unicos)
        )).

test(livro_com_dois_generos_compativeis) :-
    findall(G, (gosta(mariana, G),
                genero_livro(harry_potter_pedra_filosofal, G)), Generos),
    sort(Generos, Unicos),
    assertion(Unicos == [fantasia, infantil]),
    findall(T, recomendar(mariana, harry_potter_pedra_filosofal, T), Ts),
    assertion(Ts == ['Harry Potter e a Pedra Filosofal']).

test(livro_conhecido_incompativel, [fail]) :-
    recomendar(ana, o_hobbit).

test(usuario_inexistente_aridade_2, [fail]) :-
    recomendar(usuario_inexistente_teste, _).

test(usuario_inexistente_aridade_3, [fail]) :-
    recomendar(usuario_inexistente_teste, _, _).

test(livro_inexistente, [fail]) :-
    recomendar(ana, livro_inexistente_teste).

% Seletores de cenarios de teste: nao alteram nem duplicam a base.
% PlUnit ignora os testes condicionais quando o cadastro nao tem o perfil.
% Ausencia de cenario deve ser registrada como bloqueio, nunca como aprovacao.
usuario_preferencia_unica(U, G) :-
    usuario(U, _),
    findall(P, gosta(U, P), Ps),
    sort(Ps, [G]).

usuario_sem_preferencia(U) :-
    usuario(U, _),
    \+ gosta(U, _).

usuario_sem_livro_compativel(U) :-
    usuario(U, _),
    once(gosta(U, _)),
    \+ (gosta(U, G), genero_livro(L, G), livro(L, _)).

test(preferencia_unica_com_livros,
     [condition(once((usuario_preferencia_unica(_, G),
                       genero_livro(L, G), livro(L, _))))]) :-
    forall(usuario_preferencia_unica(Usuario, Genero),
        ( findall(Id, (genero_livro(Id, Genero), livro(Id, _)), Brutos),
          sort(Brutos, Esperados),
          ( Esperados == [] -> true ; confere_ids(Usuario, Esperados) )
        )).

test(usuario_cadastrado_sem_preferencias,
     [condition(once(usuario_sem_preferencia(_)))]) :-
    forall(usuario_sem_preferencia(U),
        ( assertion(\+ recomendar(U, _)),
          assertion(\+ recomendar(U, _, _))
        )).

test(catalogo_sem_livro_compativel,
     [condition(once(usuario_sem_livro_compativel(_)))]) :-
    forall(usuario_sem_livro_compativel(U),
        ( assertion(\+ recomendar(U, _)),
          assertion(\+ recomendar(U, _, _))
        )).

:- end_tests(recomendacoes).
