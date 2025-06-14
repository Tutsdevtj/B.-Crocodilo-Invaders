programa
{
     inclua biblioteca Graficos --> g
     inclua biblioteca Teclado --> t
     inclua biblioteca Util --> u
     inclua biblioteca Texto --> tex
     inclua biblioteca Sons --> sm


inteiro somMenu = sm.carregar_som("menu_music.mp3")
funcao audioMenu() {
	inteiro vol = 75
  
	sm.reproduzir_som(somMenu, verdadeiro)

 	sm.definir_volume_reproducao(somMenu, vol)
}

funcao menu()
     {
          g.iniciar_modo_grafico(falso)         
    
      //carregamento e redimensionamento de arquivos externos
          
          inteiro fundoMenu = g.carregar_imagem("mainMenu.png")
          inteiro setaMenu = g.carregar_imagem("seta.png")
          inteiro somSelect = sm.carregar_som("select.mp3")
          inteiro somSelection = sm.carregar_som("selection.mp3")
          inteiro larguraTela = 1200
          inteiro alturaTela = 720
          g.definir_dimensoes_janela(larguraTela, alturaTela)
          g.definir_titulo_janela("Bombardiro Crocodilo")
          fundoMenu = g.redimensionar_imagem(fundoMenu, larguraTela, alturaTela, verdadeiro)

		
          inteiro voltarSobre = 0
          inteiro opcao = 0
          enquanto (verdadeiro) {

          	
               g.limpar()
		
               g.desenhar_imagem(0, 0, fundoMenu)
               g.definir_cor(Graficos.COR_VERDE)
               g.definir_tamanho_texto(120.0)



se (t.alguma_tecla_pressionada()) {
	se (t.tecla_pressionada(t.TECLA_SETA_ACIMA)) {
		sm.reproduzir_som(somSelection, falso)
		u.aguarde(200)
		
		opcao = opcao - 1
		
	}
	se (t.tecla_pressionada(t.TECLA_SETA_ABAIXO)) {
		sm.reproduzir_som(somSelection, falso)
		u.aguarde(200)
	
		opcao = opcao + 1
		
	}
}

 se (opcao <= -1) {

	opcao = 2
               	
               }
 senao se (opcao == 3) {

 	opcao = 0
 }

 se (opcao == 0) {
 	 g.desenhar_imagem(780, 347, setaMenu)
 } 
 senao se (opcao == 1) {
 	 g.desenhar_imagem(780, 457, setaMenu)
 }
 senao se (opcao == 2) {
 g.desenhar_imagem(780, 570, setaMenu)
	
 }

 se (opcao == 0) {

se (t.tecla_pressionada(t.TECLA_ENTER)) {		
	sm.reproduzir_som(somSelect, falso)
	tick()
  	}
 }



 se (opcao == 1) {

se (t.tecla_pressionada(t.TECLA_ENTER)) {		
	sm.reproduzir_som(somSelect, falso)
	sobre()
  	}
 }

 se (opcao == 2) {

se (t.tecla_pressionada(t.TECLA_ENTER)) {	
	sm.reproduzir_som(somSelect, falso)
	retorne
  	}
 }
               g.renderizar()
          }  
     }
          
funcao sobre() {
	logico voltarSobre = verdadeiro
	inteiro fundoSobre = g.carregar_imagem("sobre.png")
	
enquanto (voltarSobre == verdadeiro) {
	 g.desenhar_imagem(0, 0, fundoSobre)
	 g.renderizar()

	 se (t.tecla_pressionada(t.TECLA_ESC)) {
	 	voltarSobre = falso
	 }
}
	
}

logico barrier = falso
inteiro timer_alert = 0
inteiro movementX = 100
inteiro movementY = 319
funcao movement_main_character() {

	se (t.tecla_pressionada(t.TECLA_SETA_ACIMA)) {
		
		movementY = movementY - 1
		se (movementY <= 3) {
			movementY = 4			
		}		
	}
	se (t.tecla_pressionada(t.TECLA_SETA_ABAIXO)) {
	
		 movementY = movementY + 1	
		se (movementY >= 450) {	

			movementY = 449		
		}		
	}
	
	se (t.tecla_pressionada(t.TECLA_SETA_ESQUERDA)) {
	
		movementX = movementX - 1
		se (movementX <= 0) {

			movementX = 1			
		}		
	}
	se (t.tecla_pressionada(t.TECLA_SETA_DIREITA)) {
		 movementX = movementX + 1	

		se (movementX >= 650) {

			movementX = 649	
			barrier = verdadeiro
			timer_alert = 100		
		} senao {
			barrier = falso
		}
	}
}

funcao logico verificarColisaoPr(inteiro canto_prmcX, inteiro canto_prmcY, inteiro larguraPrX, inteiro alturaPrX, inteiro canto_prenX, inteiro canto_prenY, inteiro larguraEnX, inteiro alturaEnX) {

se (canto_prmcX < canto_prenX + larguraEnX e canto_prmcX + larguraPrX > canto_prenX e canto_prmcY < canto_prenY + alturaEnX e canto_prmcY + alturaPrX > canto_prenY) { 
	
	retorne verdadeiro
	
	}
	senao {
		retorne falso
	}
	
}

inteiro mainC_health = 30
inteiro mainC_dmg = sm.carregar_som("mainC_dmg.mp3")
inteiro enemy1_health = 4
inteiro enemy2_health = 4
inteiro enemy_dmg = sm.carregar_som("enemy_dmg.mp3")
inteiro enemy_when_dmg = sm.carregar_som("enemy_when_dmg.mp3")
logico isEnemyAlive
logico isEnemy2Alive
inteiro enemies_killed = 0
inteiro game_over = sm.carregar_som("gameover.mp3")
inteiro enemy_death = g.carregar_imagem("enemy_death.gif")
inteiro xEffect, yEffect
logico desenhar_efeito_enemy1 = falso
inteiro timer_efeito_enemy1 = 0
logico desenhar_efeito_enemy2 = falso
inteiro timer_efeito_enemy2 = 0
logico desenhar_hit_sp = falso
inteiro hit = g.carregar_imagem("hit_effect.gif")
inteiro timer_hit = 0
inteiro sp_hit = g.carregar_imagem("sp_hit_effect.gif")
inteiro sp_dmg = sm.carregar_som("sp_sound.mp3")
inteiro timer_hit_sp = 0
logico desenhar_hit = falso
funcao colisoes() {
	
    // inimigo 1
    se (verificarColisaoPr(projectileX, projectileY, 25, 25,
        movement_enemyX + 6, movement_enemyY - 37, 65, 58)) {
        xEffect = projectileX
        yEffect = projectileY
        timer_hit = 100
        desenhar_hit = verdadeiro
        sm.reproduzir_som(enemy_when_dmg, falso)
       
        projectileX = 1300
        enemy1_health--
	
		
        se (enemy1_health == 0) {
        	 x_projectile = 900
        	xEffect = movement_enemyX
        	yEffect = movement_enemyY
        	totalPoints+= 100
        	yPoint = movementY
        	  desenhar_point = verdadeiro
        	  timer_point = 100
        	  desenhar_efeito_enemy1 = verdadeiro
   		  timer_efeito_enemy1 = 100   	  
            sm.reproduzir_som(enemy_dmg, falso)
            movement_enemyX = 1400
            movement_enemyY = u.sorteia(300, 950)
            isEnemyAlive = falso
            enemies_killed++
            ppreset++

			

            se (nao isEnemyAlive) {
                enemy1_health = 4
                isEnemyAlive = verdadeiro
            }
        }
    }
//inimigo 1 special attack colisao
    se (verificarColisaoPr(SprojectileX, SprojectileY, 50, 25,
        movement_enemyX, movement_enemyY - 37, 65, 58)) {   	
        xEffect = SprojectileX
        yEffect = SprojectileY
        timer_hit_sp = 60
        desenhar_hit_sp = verdadeiro
     
        SprojectileX = 1300
        enemy1_health -= 4

        se (enemy1_health <= 0) {
        	  xEffect = movement_enemyX
        	  yEffect = movement_enemyY
        	  totalPoints+= 400
        	  yPoint = movementY
        	  desenhar_point = verdadeiro
        	  timer_point = 100
        	  desenhar_efeito_enemy1 = verdadeiro
   		  timer_efeito_enemy1 = 100   
            sm.reproduzir_som(enemy_dmg, falso)
            movement_enemyX = 1400
            movement_enemyY = u.sorteia(200, 950)
            isEnemyAlive = falso
            enemies_killed++
            ppreset++

            se (nao isEnemyAlive) {
                enemy1_health = 4
                isEnemyAlive = verdadeiro
            }
        }
    }
    
//inimigo 2 special attack colisao
      se (verificarColisaoPr(SprojectileX, SprojectileY, 50, 25,
        movement_enemy2X, movement_enemy2Y - 37, 65, 58)) {   	
        xEffect = SprojectileX
        yEffect = SprojectileY
        timer_hit_sp = 60
        desenhar_hit_sp = verdadeiro
     
        SprojectileX = 1300
        enemy2_health -= 4

        se (enemy2_health <= 0) {
        	  xEffect = movement_enemy2X
        	  yEffect = movement_enemy2Y
        	   totalPoints+= 400
        	  yPoint = movementY
        	  desenhar_point = verdadeiro	
        	  timer_point = 100
        	  desenhar_efeito_enemy2 = verdadeiro
   		  timer_efeito_enemy2 = 100   
            sm.reproduzir_som(enemy_dmg, falso)
            movement_enemy2X = 1400
            sorteio = verdadeiro
            isEnemy2Alive = falso
            enemies_killed++
            ppreset++

            se (nao isEnemy2Alive) {
                enemy2_health = 4
                isEnemy2Alive = verdadeiro
            }
        }
    }
    
    // inimigo 2
    se (verificarColisaoPr(projectileX, projectileY, 25, 25,
        movement_enemy2X, movement_enemy2Y - 37, 65, 58)) {
        xEffect = projectileX
        yEffect = projectileY
        timer_hit = 100
        desenhar_hit = verdadeiro
        sm.reproduzir_som(enemy_when_dmg, falso)
        projectileX = 1300
        enemy2_health--

        se (enemy2_health == 0) { 
             x_projectile2 = 850
        	  xEffect = movement_enemy2X
        	  yEffect = movement_enemy2Y
        	   totalPoints+= 100
        	  yPoint = movementY
        	  desenhar_point = verdadeiro
        	  timer_point = 100
        	  desenhar_efeito_enemy2 = verdadeiro
   		  timer_efeito_enemy2 = 100   
            sm.reproduzir_som(enemy_dmg, falso)
            movement_enemy2X = 1400
            sorteio = verdadeiro
            isEnemy2Alive = falso
            enemies_killed++
            ppreset++
            timerpp = 1520
            ppSortY = u.sorteia(50, 500)
            ppX = 1300

            se (nao isEnemy2Alive) {
                isEnemy2Alive = verdadeiro
            }
			enemy2_health = 4

		
            
        }
    }

    // inimigo 2 atira no main character
    se (verificarColisaoPr(x_projectile2, movement_enemy2Y + 10, 25, 25,
        movementX, movementY, 100, 83)) {
        sm.reproduzir_som(mainC_dmg, falso)
        x_projectile2 = -60
        mainC_health--
    }

    // inimigo 1 atira no main character
    se (verificarColisaoPr(x_projectile, movement_enemyY + 10, 25, 25,
        movementX, movementY, 100, 83)) {
        sm.reproduzir_som(mainC_dmg, falso)
        x_projectile = -60
        mainC_health--
    }
	//powerups

	se (verificarColisaoPr(movementX, movementY, 100, 83,
        ppX, ppY, 62, 69)) {
        	
		sm.reproduzir_som(powerup_sound, falso)
		ppreset = 0
		ppX = -300
		projectileX = 1300
		mainC_health+= 6
		whenhp_up = verdadeiro
		timerhp_up = 100

				se(mainC_health >= 30) {
			mainC_health = 30
		}      	
        }    
}

inteiro barrier_alert = g.carregar_imagem("alert.gif")
funcao effect() {

	se (whenhp_up) {
    g.desenhar_imagem(movementX + 40, movementY - 30, hp_up)
    timerhp_up--

    se (timerhp_up <= 0) {
        whenhp_up = falso
    }
}



	se (desenhar_hit) {
    g.desenhar_imagem(xEffect + 35, yEffect + 50, hit)
    timer_hit--

    se (timer_hit <= 0) {
        desenhar_hit = falso
    }
}

se (desenhar_hit) {
    g.desenhar_imagem(xEffect + 35, yEffect + 50, hit)
    timer_hit--

    se (timer_hit <= 0) {
        desenhar_hit = falso
    }
}
	
se (desenhar_hit_sp) {
    g.desenhar_imagem(xEffect, yEffect, sp_hit)
    timer_hit_sp--

    se (timer_hit_sp <= 0) {
        desenhar_hit_sp = falso
    }
}
		se (desenhar_efeito_enemy1) {
    g.desenhar_imagem(xEffect, yEffect, enemy_death)
    timer_efeito_enemy1--

    se (timer_efeito_enemy1 <= 0) {
        desenhar_efeito_enemy1 = falso
    }
}

	se (desenhar_efeito_enemy2) {
    g.desenhar_imagem(xEffect, yEffect, enemy_death)
    timer_efeito_enemy2--

    se (timer_efeito_enemy2 <= 0) {
        desenhar_efeito_enemy2 = falso
    }
}

	se(barrier) {
		g.desenhar_imagem(movementX + 70, movementY - 40, barrier_alert)
		timer_alert--
		se(timer_alert <= 0) {
			barrier = falso
		}
	}		
}

inteiro ppreset = 0
inteiro ppY = 0, ppX = -300
inteiro health_box = g.carregar_imagem("health_box.gif")
inteiro timerpp = 0
inteiro ppSortY = 0
logico powertrue = falso

inteiro powerup_sound = sm.carregar_som("powerUp_Sound.mp3")
funcao powerUp() {
	
	
		se(ppreset >= 2) {
			ppY = ppSortY	
			se(ppX >= -200) {
				ppX--		
		g.desenhar_imagem(ppX, ppY, health_box)
		
		timerpp--
		se(ppX == -200) {
			ppreset = 0
		}
	
			}		
	}	
}
inteiro mchar_health_bar[10]
inteiro mchar_sp_bar[5]
inteiro portrait = g.carregar_imagem("portrait.png")
inteiro hp_up = g.carregar_imagem("hp_up.gif")
logico whenhp_up = falso
inteiro timerhp_up = 0
funcao mainC_health_bar() {
	
	mchar_health_bar[0] = g.carregar_imagem("hp_bar.png")
	mchar_health_bar[1] = g.carregar_imagem("hp-1.png")
	mchar_health_bar[2] = g.carregar_imagem("hp-2.png")
	mchar_health_bar[3] = g.carregar_imagem("hp-3.png")
	mchar_health_bar[4] = g.carregar_imagem("hp-4.png")
	mchar_health_bar[5] = g.carregar_imagem("hp-5.png")
	mchar_health_bar[6] = g.carregar_imagem("hp-6.png")
	mchar_health_bar[7] = g.carregar_imagem("hp-7.png")
	mchar_health_bar[8] = g.carregar_imagem("hp-8.png")
	
	mchar_sp_bar[0] = g.carregar_imagem("special.png")
	mchar_sp_bar[1] = g.carregar_imagem("special-1.png")
	mchar_sp_bar[2] = g.carregar_imagem("special-2.png")
	mchar_sp_bar[3] = g.carregar_imagem("special-3.png")
	mchar_sp_bar[4] = g.carregar_imagem("special-4.png")
}

funcao mainC_health_bar_att() {

	g.desenhar_imagem(20, 600, portrait)

	se(mainC_health > 27) {
	g.desenhar_imagem(140, 650, mchar_health_bar[0])
	}
	senao se(mainC_health > 24 e mainC_health <= 27) {
		g.desenhar_imagem(140, 650, mchar_health_bar[1])
	}
	senao se	(mainC_health > 21 e mainC_health <= 24) {
		g.desenhar_imagem(140, 650, mchar_health_bar[2])
	}
	senao se		(mainC_health > 18 e mainC_health <= 21) {
		g.desenhar_imagem(140, 650, mchar_health_bar[3])
	}
	senao se			(mainC_health > 15 e mainC_health <= 18) {
		g.desenhar_imagem(140, 650, mchar_health_bar[4])
	}
	senao se			(mainC_health > 12 e mainC_health <= 15) {
		g.desenhar_imagem(140, 650, mchar_health_bar[5])
	}
	senao se			(mainC_health > 5 e mainC_health <= 12) {
		g.desenhar_imagem(140, 650, mchar_health_bar[6])
	}
	senao se			(mainC_health >= 1 e mainC_health <= 8) {
		g.desenhar_imagem(140, 650, mchar_health_bar[7])
	}
	senao se				(mainC_health <= 0) {
		g.desenhar_imagem(140, 650, mchar_health_bar[8])
		gameover()
	}

	se(SpCharge < 2) {
	g.desenhar_imagem(140, 680, mchar_sp_bar[4])
	}
	senao se(SpCharge >= 2 e SpCharge < 4) {
		g.desenhar_imagem(140, 680, mchar_sp_bar[3])
	}
	senao se	(SpCharge >= 4 e SpCharge < 6) {
		g.desenhar_imagem(140, 680, mchar_sp_bar[2])
	}
	senao se		(SpCharge >= 6 e SpCharge < 10) {
		g.desenhar_imagem(140, 680, mchar_sp_bar[1])
	}
	senao se			(SpCharge >= 10) {
		g.desenhar_imagem(140, 680, mchar_sp_bar[0])
	}
	
}

funcao gameover() {
	gameovermenu()	
	isPlaying = falso
	se (nao isPlaying) {
		reset()
		retorne	
	}
}

funcao gameovermenu() {
sm.reproduzir_som(game_over, falso)
	
}

inteiro larguraHitBox = 100
inteiro alturaHitBox = 83
inteiro hitboxColor = g.criar_cor(0, 0, 0)
funcao main_character_hitbox() {	
	g.definir_cor(hitboxColor)
  	g.desenhar_retangulo(movementX, movementY, larguraHitBox, alturaHitBox, falso, falso)
  	g.desenhar_retangulo(projectileX, projectileY + 45, 25, 25, falso, falso)		
}

inteiro movement_enemyY = 350
inteiro x_projectile = 900
inteiro largura_enemy_hit = x_projectile - 5
inteiro altura_enemy_hit = movement_enemyY + 10

funcao enemy_hitbox() {
	
	g.desenhar_retangulo(movement_enemyX, movement_enemyY, 65, 58, falso, falso)
	g.desenhar_retangulo(x_projectile - 5, movement_enemyY + 10, 25, 25, falso, falso)

			   
}	
//load arquivos e variaveis globais referentes ao mapa do jogo

	inteiro background = g.carregar_imagem("background.png")
	inteiro ground = g.carregar_imagem("ground.png")
	 
	inteiro mainC_projectile = g.carregar_imagem("projectile.png") 
	inteiro sun = g.carregar_imagem("sun.gif") 
	
	inteiro cloud1 = g.carregar_imagem("cloud.png") 
	inteiro cloud2 = cloud1
	inteiro map_cloud_movementX = 2
	inteiro cloud_height1 = 15
	inteiro cloud_height2 = 55
	inteiro x_cloud1 = 400 
	inteiro x_cloud2 = 750
	
	inteiro x_ground1 = 0
	inteiro x_ground2 = 1199		
	inteiro map_ground_movementX = 1	
funcao drawMap() { 			
	g.desenhar_imagem(0,0, background)	
	g.desenhar_imagem(x_ground1 = x_ground1 - map_ground_movementX, 530, ground)	
	g.desenhar_imagem(x_ground2 = x_ground2 - map_ground_movementX, 530, ground)	 
	g.desenhar_imagem(510,70, sun)
	g.desenhar_imagem(x_cloud1 -= map_cloud_movementX, cloud_height1, cloud1)
	g.desenhar_imagem(x_cloud2 -= map_cloud_movementX, cloud_height2, cloud2)
	g.definir_cor(hitboxColor)
	g.definir_estilo_texto(falso, verdadeiro, falso)
	g.definir_tamanho_texto(16.0)
	g.desenhar_texto(165, 632, "B. Crocodilo")
//implementar posição aleatória das nuvens <feito
//aumento de velocidade gradual
	se (x_cloud1 == -200) {		
		x_cloud1 = 2000
		cloud_height1 = cloud_height1 + 45
		
		se (cloud_height1 > 200) {
			cloud_height1 = 33
	}
	}
	se (x_cloud2 == -200) {
		x_cloud2 = 2000	
		cloud_height2 = cloud_height2 + 75
		se (cloud_height2 > 300) {
			cloud_height2 = 78
		}
	}	
	se (x_ground1 == -1200) {
		x_ground1 = 0
	}
	se (x_ground2 == 0) {
		x_ground2 = 1200
	}
		
}

// variaveis globais attack
logico isAttacking = falso
logico isSpecialAtk = falso
inteiro SpCharge = 0
inteiro projectileX = 0
inteiro projectileY = 0
inteiro SprojectileY = 0
inteiro SprojectileX = 0
inteiro mainC_projectile_sound = sm.carregar_som("mainC_projectile_sound.mp3")
inteiro Sprojectile = g.carregar_imagem("Sprojectile_effect.gif")
funcao main_character_attack() {
	
    se (t.tecla_pressionada(t.TECLA_ESPACO) e nao isAttacking) {
    	   SpCharge++
        isAttacking = verdadeiro
        sm.reproduzir_som(mainC_projectile_sound, falso)
        projectileY = movementY
        projectileX = movementX
    }

    se (isAttacking) {
        projectileX += 5
        g.desenhar_imagem(projectileX, projectileY + 45, mainC_projectile)

        se (projectileX > 1225) {
            isAttacking = falso
        }
    }

		se(SpCharge >= 10) {
			SpCharge = 10	
		}
	se (t.tecla_pressionada(t.TECLA_C) e nao isSpecialAtk e SpCharge >= 10) {
		isSpecialAtk = verdadeiro
		sm.reproduzir_som(sp_dmg, falso)
		SprojectileY = movementY
		SprojectileX = movementX		
		SpCharge -= 10	
		
	}

	se(isSpecialAtk) {
		SprojectileX+= 5
		g.desenhar_imagem(SprojectileX, SprojectileY, Sprojectile)
		se(SprojectileX > 2000) {
			isSpecialAtk = falso
		}
	}		
    
}

funcao pause() {

	se (t.tecla_pressionada(t.TECLA_P)) {

		u.aguarde(21474836)
		
	}senao se (t.tecla_pressionada(t.TECLA_P)) {
		u.aguarde(0)	
	}
}

inteiro enemy_projectile = g.carregar_imagem("enemy_projectile.png")
inteiro movement_enemyX = 1400
logico is_enemy_attacking = falso
inteiro enemy_projectile_sound = sm.carregar_som("enemy_projectile_sound.mp3")
funcao initial_movement_enemy1() {
	movement_enemy2()
	se (movement_enemyX >= 900) {
		movement_enemyX = movement_enemyX - 1	
	}
	se (movement_enemyX == 899) {
		
		se (movement_enemyY != 225) {
			movement_enemyY = movement_enemyY - 1
			} 
			se(movement_enemyY == 225 e x_projectile > -200) {
				
				x_projectile -= 2	

				g.desenhar_imagem(x_projectile, movement_enemyY + 10, enemy_projectile)			
				is_enemy_attacking = verdadeiro	

				se (is_enemy_attacking e x_projectile <= -200) {
				x_projectile = 900
			}
		}			
	}

	se (x_projectile == 840) {
		sm.reproduzir_som(enemy_projectile_sound, falso)	
	}
			
}
inteiro movement_enemy2X = 1700
inteiro movement_enemy2Y = 400
logico sorteio = falso
inteiro sorteadoY = 0
inteiro x_projectile2 = 0
inteiro y_projectile2 = 0
funcao movement_enemy2() {
		
		se (sorteio == verdadeiro) {
			sorteadoY = u.sorteia(250, 500)
			movement_enemy2Y = sorteadoY
			sorteio = falso
		}

		se (movement_enemy2X != 850) {
			movement_enemy2X-= 1
}
			se(movement_enemy2X == 850 e x_projectile2 < -200) {
				x_projectile2 = movement_enemy2X	
				y_projectile2 = 400
				}
				
				se (x_projectile2 > -200 e movement_enemy2X == 850) {
					x_projectile2 -= 2
					g.desenhar_imagem(x_projectile2, movement_enemy2Y, enemy_projectile)
					
				}
		se (x_projectile2 == -200) {
			x_projectile2 = 850
		}
		se (x_projectile2 == 840) {
			sm.reproduzir_som(enemy_projectile_sound, falso)
		}	
}

logico appearBoss = falso
funcao boss_fight() {











	
}


funcao verificarMorteEn() {
	se(isEnemyAlive e nao appearBoss) {
	initial_movement_enemy1()
	}

}

inteiro yPoint = 0
inteiro totalPoints = 0
inteiro timer_point = 0
logico desenhar_point = falso
inteiro coinUp = g.carregar_imagem("coin.gif")
funcao points() {


		
se (desenhar_point) {
	se(yPoint != 0) {
		yPoint--
	}
    g.desenhar_imagem(movementX + 60, yPoint - 20, coinUp)
    timer_point--

    se (timer_point <= 0) {
        desenhar_point = falso
    }
}
}

funcao reset() {
	
	mainC_health = 30
	movementX = 100
	movementY = 319
	movement_enemyX = 1400
	movement_enemyY = 550
	movement_enemy2X = 1400
	movement_enemy2Y = 350
	enemy1_health = 4
	enemy2_health = 4		
	SpCharge = 0
	enemies_killed = 0
	appearBoss = falso
	sm.definir_posicao_atual_musica(somMenu, 0)
	
}


inteiro mainCharacter = g.carregar_imagem("character.png")
inteiro enemy1 = g.carregar_imagem("enemy1.gif")
logico isPlaying = falso
funcao tick() {	
	isPlaying = verdadeiro	
	isEnemyAlive = verdadeiro
	mainC_health_bar()
	//speed()	
	enquanto (isPlaying == verdadeiro) {	
	drawMap()
	g.desenhar_imagem(movementX, movementY, mainCharacter)
	g.desenhar_imagem(movement_enemyX, movement_enemyY, enemy1)
	g.desenhar_imagem(movement_enemy2X, movement_enemy2Y, enemy1)
	pause()
 	main_character_attack()	
 	mainC_health_bar_att()
	movement_main_character()	
	colisoes()
	powerUp()
	points()
	effect()
	//main_character_hitbox()
	//enemy_hitbox()	
	verificarMorteEn()
	g.renderizar()
	
	u.aguarde(3)
	
	se (t.tecla_pressionada(t.TECLA_ESC)) {
		reset()
		isPlaying = falso				
	}	
	}		
}   

     funcao inicio()
     {

		
 		//audioMenu()
          menu()
       
     }
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 20789; 
 * @DOBRAMENTO-CODIGO = [18, 703];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = {enemy2_health, 191, 8, 13}-{enemies_killed, 196, 8, 14};
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */