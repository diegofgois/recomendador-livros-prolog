:- module(base_conhecimento_generos, [genero/2, genero_livro/2]).

genero(romance, 'Romance').
genero(fantasia, 'Fantasia').
genero(ficcao_cientifica, 'Ficção científica').
genero(suspense, 'Suspense').
genero(terror, 'Terror').
genero(aventura, 'Aventura').
genero(biografia, 'Biografia').
genero(historia, 'História').
genero(infantil, 'Infantil').
genero(quadrinhos, 'Quadrinhos').

genero_livro(orgulho_preconceito, romance).
genero_livro(jane_eyre, romance).
genero_livro(dom_casmurro, romance).
genero_livro(amor_nos_tempos_colera, romance).
genero_livro(grande_gatsby, romance).

genero_livro(o_senhor_dos_aneis, fantasia).
genero_livro(o_senhor_dos_aneis, aventura).
genero_livro(o_hobbit, fantasia).
genero_livro(o_hobbit, aventura).
genero_livro(harry_potter_pedra_filosofal, fantasia).
genero_livro(harry_potter_pedra_filosofal, infantil).
genero_livro(as_cronicas_de_narnia_leao_feiticeira_guarda_roupa, fantasia).
genero_livro(as_cronicas_de_narnia_leao_feiticeira_guarda_roupa, infantil).
genero_livro(a_historia_sem_fim, fantasia).
genero_livro(a_historia_sem_fim, infantil).

genero_livro(duna, ficcao_cientifica).
genero_livro(duna, aventura).
genero_livro(fundacao, ficcao_cientifica).
genero_livro(neuromancer, ficcao_cientifica).
genero_livro(odisseia_2001, ficcao_cientifica).
genero_livro(fahrenheit_451, ficcao_cientifica).

genero_livro(o_codigo_da_vinci, suspense).
genero_livro(assassinato_no_expresso_oriente, suspense).
genero_livro(o_silencio_dos_inocentes, suspense).
genero_livro(a_garota_no_trem, suspense).
genero_livro(os_homens_que_nao_amavam_as_mulheres, suspense).

genero_livro(it_a_coisa, terror).
genero_livro(o_iluminado, terror).
genero_livro(dracula, terror).
genero_livro(frankenstein, terror).
genero_livro(frankenstein, ficcao_cientifica).
genero_livro(a_assombracao_da_casa_da_colina, terror).

genero_livro(a_ilha_do_tesouro, aventura).
genero_livro(as_minas_do_rei_salomao, aventura).
genero_livro(as_aventuras_de_tom_sawyer, aventura).
genero_livro(as_aventuras_de_tom_sawyer, infantil).
genero_livro(vinte_mil_leguas_submarinas, aventura).
genero_livro(vinte_mil_leguas_submarinas, ficcao_cientifica).
genero_livro(o_chamado_selvagem, aventura).

genero_livro(uma_breve_historia_do_tempo, historia).
genero_livro(diarios_de_frida_kahlo, biografia).
genero_livro(long_walk_to_freedom, biografia).
genero_livro(o_diario_de_anne_frank, biografia).
genero_livro(o_diario_de_anne_frank, historia).
genero_livro(steve_jobs, biografia).

genero_livro(sapiens, historia).
genero_livro(armas_germes_e_aco, historia).
genero_livro(o_principe, historia).
genero_livro(holocausto, historia).
genero_livro(a_era_dos_extremos, historia).

genero_livro(o_pequeno_principe, infantil).
genero_livro(alice_no_pais_das_maravilhas, infantil).
genero_livro(alice_no_pais_das_maravilhas, fantasia).
genero_livro(matilda, infantil).
genero_livro(percy_jackson_ladrao_de_raios, infantil).
genero_livro(percy_jackson_ladrao_de_raios, fantasia).
genero_livro(o_menino_do_pijama_listrado, infantil).
genero_livro(o_menino_do_pijama_listrado, historia).

genero_livro(maus, quadrinhos).
genero_livro(maus, historia).
genero_livro(watchmen, quadrinhos).
genero_livro(batman_ano_um, quadrinhos).
genero_livro(mulher_maravilha_deusa_da_guerra, quadrinhos).
genero_livro(a_liga_extraordinaria, quadrinhos).
genero_livro(a_liga_extraordinaria, aventura).
