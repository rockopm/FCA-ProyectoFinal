
	+++++++++++++++++++++
	+ Codigo caracteres +
	+++++++++++++++++++++
	
	Ctrl + Shift + u -->
	
	Ø	-->		00d8
	Ս	-->		144c
	Ո	-->		144e
	ᕫ	-->		156b

	++++++++++++++++++++++++++++
	+ ARITMETICA DE INTERVALOS +
	++++++++++++++++++++++++++++
	
	
	
		I. Al calcular un intervalo X = [a,b] que contiene la solución, podemos dar un resultado definiendo
			
			m = mid(X) =  (b-a)/2
			
		y ofreciendo a m como el resultado. En este caso tendremos
		
		
			| x - m | <= w/2
			
			
		donde w es la longitud (width) del intervalo, es decir, w = b-a. Entonces obtenemos una aproximación de la solución
		con m y un rango de error dado por X.
		
		II. ¿PORQUE USAMOS INTERVALOS?
		
		Si en vez de realizar operaciones preocupándonos por la presición de máquina, mejor utilizamos una aproximación por
		intervalos, en donde acotamos el resultado exacto y nos preocupamos por que la longitud w del intervalos sea pequeña.
		
		III. INTERVALO
		
		Un intervalo se define como 
		
			[a,b] = {x in R : a <= x <= b} 	// implementado como 'Intervalo(a,b)'
			
		Denotamos, normalmente, a un intervalo con letras mayusculas
		
			X = [Xi, Xs]
			
		Decimos que dos intervalos X y Y son iguales si son el mismo conjunto. Matemáticamente, eso pasa si sus extremos son
		iguales
		
			X = Y si Xi = Yi & Xs = Ys
			
		Un INTERVALO DEGENERADO X es aquel que satisface
		
			Xi = Xs
			
		Un intervalo degenerado contiene un sólo número real. Identificamos a un intervalo degenaro con el número real que
		corresponde, y podemos escribir
		
			x = [x,x], con x un Real
			
		IV. INTERSECCION, UNION Y COVERTURA DE UN INTERVALO
		
		1) La INTERSECCION de dos intervalos X y Y es VACIA si 
		
			Ys < Xi   or   Yi < Xs
			
		Para este caso denotamos Ø al conjunto (en nuestro caso será intervalo) vacío como
		
			X ᑎ Y = Ø
			
		indicando que X y Y no tienen puntos en común. En otro caso, en que no son vacíos, definimos la intersección de 
		intervalos como
		
			X ᑎ Y = {z : z in X   and   z in Y} = [max{Xi, Yi},  min{Xs, Ys}] 	// implementada como 'intersect'
			
		2) La UNION de dos intervalos X y Y se define como intervalo
		
			X ᑌ Y = {z : z in X   or   z in Y} = [min{Xi, Yi},  max{Xs, Ys}] 	// implementada como 'union'
		
		3) Dado que la union de intervalos no siempre es un intervalo (cuando este es un conjunto no conexo), se utiliza la 
		COVERTURA DE UN INTERVALO para definir
		
			X ᕫ Y = [min{Xi, Yi},  max{Xs, Ys}]
			
		este es un intervalo que contiene los intervalos que corresponde a la union de X y Y, en caso de que estos sean disjuntos,
		y esta covertura de intervalo cumple
		
			X ᑌ Y   in   X ᕫ  Y
		
		
		Se tiene una pérdida de información cuando se utiliza la COVERTURA en vez de la UNION, y cuando la última es un conjunto no
		conexo, pero es más fácil trabajar con esta en cálculos computacionales. Pero la pérdida de información no es crítica [Moore].
		
		LONGITUD, VALOR ABSOLUTO Y PUNTO MEDIO
		
		1) Definimos la LONGITUD DE UN INTERVALO como
		
			w = Xs - Xi 	// implementada como 'long'
			
			
		2) Definimos el VALOR ABSOLUTO DE UN INTERVALO como el máximo valor absoluto de sus extremo
		
			|X| = max{|Xi|, |Xs|} 	// implementada como 'abs'
			
		Notamos que para todo punto x in X se cumple |x| <= |X|.
		
		3) El PUNTO MEDIO de un intervalo se define como 
		
			m = (1/2)*(Xi + Xs) 	// implementada como 'mid'
			
			
		OPERACIONES ARITMETICAS CON INTERVALOS
		
		Se consideran 4 operaciones:
		
			1) Suma
			2) Resta
			3) Multiplicación
			4) División
			
		1) SUMA
		
		3) MULTIPLICACION
		
			Se había definido usando el código
			
				function *(A::Intervalo, B::Intervalo)
				    values = [A.a*B.a, A.a*B.b, A.b*B.a, A.b*B.b]
				    return Intervalo(minimum(values), maximum(values))
				end
			
			pero mejor se implementó el algoritmo que viene en el Moore.

		
		
