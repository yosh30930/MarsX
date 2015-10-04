function love.load()
	
	--Damos un color por default en caso de haber espacios sin llenar
	love.graphics.setBackgroundColor(255, 255, 255)
	--Damos dimensiones a nuestra area de juego
	love.window.setMode(1024, 620)
	--Nombre del videojuego
	love.window.setTitle("MARS X")
	--Cargamos cada uno de los marcianos y los agregamos a la tabla marcianos
	marciano1 = {imagen = love.graphics.newImage("Images/marciano.png"), x = 500, y = 50, velocidad= 1.5,numcolisiones = 0}
	marciano6 = {imagen = love.graphics.newImage("Images/marciano.png"), x = 700, y = 140, velocidad= 1.5,numcolisiones = 0}
	marciano7 = {imagen = love.graphics.newImage("Images/marciano.png"), x = 400, y = 180, velocidad= 1.5,numcolisiones = 0}
	marciano8 = {imagen = love.graphics.newImage("Images/marciano.png"), x = 500, y = 200, velocidad= 1.5, numcolisiones = 0}
	marciano9 = {imagen = love.graphics.newImage("Images/marciano.png"), x = 500, y = 400, velocidad= 1.5,numcolisiones = 0}
	marciano10 = {imagen = love.graphics.newImage("Images/marciano.png"), x = 900, y = 550, velocidad= 1.5, numcolisiones = 0}
	marciano2 = {imagen = love.graphics.newImage("Images/marciano.png"), x = 350, y = 300, velocidad= 1.5,numcolisiones = 0}
	marciano3 = {imagen = love.graphics.newImage("Images/marciano.png"), x = 310, y = 390, velocidad= 1.5,numcolisiones = 0}
	marciano4 = {imagen = love.graphics.newImage("Images/marciano.png"), x = 540, y = 550, velocidad= 1.5,numcolisiones = 0}
	marciano5 = {imagen = love.graphics.newImage("Images/marciano.png"), x = 310, y = 150, velocidad= 1.5,numcolisiones = 0}
	marcianos = {marciano1,marciano2,marciano3,marciano4,marciano5, marciano6,marciano7,marciano8,marciano9,marciano10}
	--Cargamos las plataformas sobre las que estarán parados los marcianos disparando
	plataformaAzul = {imagen = love.graphics.newImage("Images/plataformaazul.png"), x = 400, y = 100}
	plataformaGris = {imagen = love.graphics.newImage("Images/plataformagris.png"), x = 400, y = 230}
	plataformaGris1 = {imagen = love.graphics.newImage("Images/plataformagris.png"), x = 500, y = 250}
	--Tabla de balas del astronauta
	bullets = {}
	--Les damos velocidad
	bulletSpeed = 550 
	--Tabla de las balas que disparan los extraterrestres
	bulletsMarcianos = {}
	--Les asignamos velocidad dependiendo de que dificultad vaya a tener ese nivel.
	bulletSpeedMarciano = 200
	--Cargamos el fondo sobre el que correrá el juego
	bg = love.graphics.newImage("Images/fondomars2_converted.png")
	--Le asignamos sus valores a astronauta, de x,y,velocidad y el numero de colisiones que nos dirán si sigue vivo o no
	astronauta = {imagen = love.graphics.newImage("Images/stormtrooper.png"), x = 20, y = bg:getHeight()-100, velocidad= 4.0, numcolisiones = 0}
	--Vidas que desplegaremos para saber cuantas nos quedan
	lives = {imagen = love.graphics.newImage("Images/vidas.png"), x = 900, y = 0}

end --load

function love.draw()

	--Ponemos el fondo blanco
	love.graphics.setColor(255,255,255,255)
	--Dibujamos en fondo
	love.graphics.draw(bg)
	--Dibujamos al astronauta
	love.graphics.draw(astronauta.imagen,astronauta.x,astronauta.y)
	--Volvemos a poner el color en blanco
	love.graphics.setColor(255,255,255,255)

	--Dibujamos los marcianos en la tabla marcianos
	for j,marciano in ipairs(marcianos) do
		if not (marciano.numcolisiones >3) then
			love.graphics.draw(marciano.imagen,marciano.x,marciano.y)
		end
	end



--checa vidas y disminuye en caso de colisiones

if (astronauta.numcolisiones == 0) then
	love.graphics.draw(lives.imagen,lives.x,lives.y)
	
	else if(astronauta.numcolisiones ==1)then
		love.graphics.draw(lives.imagen,lives.x,lives.y)
		love.graphics.draw(lives.imagen,lives.x + 40,lives.y)
		else if	(astronauta.numcolisiones == 2)then
			love.graphics.draw(lives.imagen,lives.x,lives.y)	
		end
	end
end

	--plataformas
	love.graphics.draw(plataformaGris.imagen,plataformaGris.x,plataformaGris.y)
	love.graphics.draw(plataformaGris.imagen,plataformaGris.x-100,plataformaGris.y-30)
	love.graphics.draw(plataformaGris.imagen,plataformaGris.x+300,plataformaGris.y-40)
	love.graphics.draw(plataformaGris.imagen,plataformaGris.x+350,plataformaGris.y-40)
	love.graphics.draw(plataformaGris.imagen,plataformaGris.x+250,plataformaGris.y-40)
	love.graphics.draw(plataformaGris.imagen,plataformaGris.x-80,plataformaGris.y+120)
	love.graphics.draw(plataformaGris1.imagen,plataformaGris1.x,plataformaGris1.y)
	love.graphics.draw(plataformaAzul.imagen,plataformaAzul.x,plataformaAzul.y)
	love.graphics.draw(plataformaAzul.imagen,plataformaAzul.x+80,plataformaAzul.y+350)
	love.graphics.draw(plataformaAzul.imagen,plataformaAzul.x-110,plataformaAzul.y+340)
	love.graphics.draw(plataformaAzul.imagen,plataformaAzul.x+ 70,plataformaAzul.y)
	
--Dibujamos las balas que dispara el astronauta
for i,bullet in ipairs(bullets) do
	love.graphics.setColor(255,10,0)
	love.graphics.circle("fill", bullet.x, bullet.y, 3)

end	

--Dibujamos las balas que disparan los marcianos.
for  i,balamarcianos in ipairs(bulletsMarcianos) do
		--Checamos que la bala este dentro de el area de juego, si no es el caso no la pintamos para no deserdiciar memoria
		--Tambien se agrega la condicion para que tan seguido los marcianos disparan, en este caso las balas en el
		--arreglo cuya posición sea modulo 271. Se recomienda pasar un numero primo para esa condición.
		if balamarcianos.y > 0 and balamarcianos.y<620 and balamarcianos.x<1024 and balamarcianos.x>0 and i%271 == 0 then
			love.graphics.setColor(0,10,220)
			love.graphics.circle("fill", balamarcianos.x, balamarcianos.y, 3)

		end
--Si ya no hay ningun marciano en el arreglo, desplegamos un mensaje en la pantalla de que el nivel ha sido completado.
if(next(marcianos) == nil) then
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.print("Nivel completado", 400, 200, 0, 2, 2)
end
end	

end-- fin del draw

function love.update(dt)
	--Mandamos a llamar a la funcion disparoMarciano, la cual hace que cada uno de los marcianos que agreguemos disparen.
	disparoMarciano()
	--Controles para el juego, w te mueve hacia arriba, a izquierda, d derecha, s hacia abajo.
	if love.keyboard.isDown('d') then astronauta.x = astronauta.x + astronauta.velocidad end
	if love.keyboard.isDown('a') then astronauta.x = astronauta.x - astronauta.velocidad end
	if love.keyboard.isDown('s') then astronauta.y = astronauta.y + astronauta.velocidad end
	if love.keyboard.isDown('w') then astronauta.y= astronauta.y - astronauta.velocidad end 
	
	--disparo astronauta	
	for i,bullet in ipairs(bullets) do
	--Le da movimiento a las balas en x y en Y al crear las balas-
	bullet.x = bullet.x + (bullet.dx * dt)
	bullet.y = bullet.y + (bullet.dy * dt)
	--Lo hace para cada  marciano
	for j,marciano in ipairs(marcianos) do
	--checamos la colision con nuestro metodo collide
	if collide(bullet, marciano) then
	--Aumentamos un contador para cada que una bala le de a un marciano y de esta manera 
	--decimos a las cuantas colisiones va a estar muerto.
	marciano.numcolisiones = marciano.numcolisiones + 1 
end
	--Para nuestro juego, a las tres colisiones un marciano se toma como muerto y se elimina de la tabla marcianos.
	if(marciano.numcolisiones == 3) then
		table.remove(marcianos,j)
	end

end
	--Cuando las balas salgan de la pantalla las eliminamos de igual manera en nuestra tabla bullets
	if bullet.y < 0 or bullet.x>1024 or bullet.x<0 then 
		table.remove(bullets, i)
	end
end

--disparos marcianos

for i,bulletmarciano in ipairs(bulletsMarcianos) do
	
	--Contamos las colisiones en nuestro astronauta para ir disminuyendo sus vidas.
	if collide(bulletmarciano, astronauta) then
		astronauta.numcolisiones = astronauta.numcolisiones + 1
	end
end
	--Movimiento para las balas de los marcianos.
	for i,bulletmarciano in ipairs(bulletsMarcianos) do
		bulletmarciano.x = bulletmarciano.x + (bulletmarciano.dx * dt)
		bulletmarciano.y = bulletmarciano.y + (bulletmarciano.dy * dt)		
		--Cuando las balas salgan de la pantalla las eliminamos de igual manera en nuestra tabla bullets
		if bulletmarciano.y < 0 or bulletmarciano.x>1024 or bulletmarciano.x<0 then
			table.remove(bulletmarciano, i)
		end
	end

end --fin del update


--Funcion para disparar con el mouse
function love.mousepressed(x, y, button)
	--boton izquierdo
	if button == "l" then
		local startX = astronauta.x + 20 --en que parte empieza el disparo sobre x
		local startY = astronauta.y  + 10--en que parte empieza el disparo sobre y
		local mouseX = x --posicion en x del mouse
		local mouseY = y --posicion en y del mouse

		local angle = math.atan2((mouseY - startY), (mouseX - startX)) -- angulo de siparo calculando el arco tangente cuadrado de la diferencia en x y en y
		local bulletDx = bulletSpeed * math.cos(angle) --Velocidad en x
		local bulletDy = bulletSpeed * math.sin(angle) --Velocidad en y

		--Insertamos en la tabla de balas ya al haber sacado todos los elementos necesarios que tendrá una bala
		table.insert(bullets, {x = startX, y = startY, dx = bulletDx, dy = bulletDy})
	end
end


--Funcion para el disparo de los marcianos, ocupa la misma logica que la del astronauta pero cambia en que estos disparos los hace la maquina
--Se podría implementar para que la máquina prediga el siguiente movimiento del astronauta pero este dispara directamente
function disparoMarciano()
	for j,marciano in ipairs(marcianos) do
		--Checa si el marciano aun esta vivo
		if not (marciano.numcolisiones >3) then
		--el marciano dispara		
		local startmarcianoX = marciano.x + 20 
		local startmarcianoY = marciano.y  + 10	
		--siempre hacia el astronauta
		local posicionastronautaX = astronauta.x
		local posicionastronautaY = astronauta.y

		local angle = math.atan2((posicionastronautaY - startmarcianoY), (posicionastronautaX - startmarcianoX))

		local bulletDx = bulletSpeedMarciano * math.cos(angle) 
		local bulletDy = bulletSpeedMarciano * math.sin(angle) 



		table.insert(bulletsMarcianos, {x = startmarcianoX, y = startmarcianoY, dx = bulletDx, dy = bulletDy})

	end--for
end--disparo marciano

end

--colisiones
function collide(bullet, character)
	return ((math.abs(bullet.x - character.x) * 2) < (3 + character.imagen:getWidth())) and
	((math.abs(bullet.y - character.y) * 2) < (3 + character.imagen:getHeight()))
end

