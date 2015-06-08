*Maestría en Ciencias Físicas: Física Computacional Avanzada*

---

# Código para encontrar rigurosamente el mínimo de una función en un intervalo

**Christian Marchen$^{(1)}$, Rodrigo Pineda Mondragón$^{(2)}$**

(1) Maestría en Ciencias Matemáticas, IIMAS, UNAM. GitHub: hierro40
(2) Maestría en Ciencias Matemáticas, IIMAS, UNAM. GitHub: rockopm

---

*
**Abstract: ** El problema de optimización de funciones es ubicuo en el mundo de las matemáticas aplicadas. La física, las finanzas, la biología, las ecuaciones diferenciales y demás ciencias que utilizan las matemáticas como herramienta de estudio convergen en algún punto en algún problema de optimización. Además, la complejidad de los nuevos modelos matemáticos desarrollados en estas ciencias nos obligan a hacer uso de herramientas computacionales cuando estos carecen de soluciones en forma cerradas. Existen métodos numéricos desarrollados para resolver el problema de encontrar el mínimo de una función dada una aproximación inicial, pero la mayoría de estos arrojan soluciones que dependen de esta primera aproximación dada por el usuario. Sin embargo, los métodos para encontrar raíces de funciones han sido extendidos para utilizar intervalos como aproximación inicial, en vez de puntos, por lo que el hecho de que $f'(x) = 0$ implique un punto crítico de $f$ nos ayuda a mejorar estos métodos para encontrar raíces de la derivada de esta función y así concluir si es un mínimo o no. En este trabajo desarrollamos un código rigusoro basado en el **método de Krawczyk** para encontrar los mínimos de una función en un intervalo dado por el usuario. Utilizamos un catálogo de **funciones suaves** para mostrar la efectividad del método.*

## Introducción

Los problemas de optimización en escencia consisten en obtener el valor mínimo $y^*$ de una función $f : D \rightarrow \mathbb{R}$ dada en una región $D$. Es decir:

$$y^* = y^*(f;D) = \inf \{f(x): x \in D \}$$

así como el conjunto de puntos del dominio $D$ donde se alcanza dicho mínimo:

$$E^* = E^*(f:D) = \{ x^* \in D: f(x^*) = y^* \}$$

Para el caso en que el problema de optimización requiera encontrar un valor máximo en vez de un mínimo entonces basta con minimizar la función $-f$ . Se asume que $f$ es continua en su dominio $D$, el cuál es un compacto. Entonces, dado que toda función continua en un intervalo cerrado y acotado alcanza un mínimo, tendremos que el conjunto $E^*$ es no vacío.

Utilizaremos técnicas de análisis de intervalos para ubicar a $y^*$ y $E^*$ en un intervalo suficientemente pequeño para que nos brinde información concluyente. Comenzando con el valor extremo $y^*$ podemos expresarlo como:

$$y^* = \inf \{ y : y \in R(f;D) \},$$

donde $R(f;D) = \{ f(x) : x \in D \}$. Por lo tanto, si podemos encerrar $R(f;D)$ en un intervalo suficientemente pequeño, entonces inmediatamente tendremos un intervalo suficientemente pequeño que encierre a $y^*$. 

Las técnicas a utilizar conocidas son muy similares a los métodos para encontrar ceros, como el método de Newton para intervalos visto en clase. Excluyendo los subconjuntos de $D$, se tratará de resolver el problema:

$$f(x) \leq \bar{y} $$

pero con una $\bar{y}$ variable, que es la cota superior actual de $y^*$. Durante el proceso de resolver esta última expresión encontraremos un valor cada vez más pequeño para $\bar{y}$ , la meta será hacer $\bar{y}$ lo más cercano posible a $y^*$, ya que estaríamos llegando al conjunto deseado:

$$E^* = \{ x^* \in D : f(x^*)\leq y^*\} = \{ x^* \in D : f(x^*)=y^* \}$$

Entonces, deseamos encontrar un intervalo $X$ que contenga a $y^*$. Se pueden utilizar distintos criterios para descartar los subintervalos en la búsqueda. En nuestro caso utilizamos un criterio de bisección para dividir el intervalo de búsqueda y usamos el resulado principal del **método de Krawczyk** para descartar intervalos que no contengan el mínimo$^{[1]}$.

## Método de Krawcyk

El **método de Krawczyk** es una alternativa al método de Newton para encontrar ceros de funciones, pues Krawczyk evita los problemas de dividir entre el intervalo $F'(X)$ cuando estamos haciendo las iteraciones del método de Newton. El método se deriva como sigue.

Se supone que $f \in C^1 (X \in \mathbb{R})$ tiene un cero $x^* \in X$. Expandimos en Taylor alrededor de $x^*$ para obtener:

$$f(x)=f(x^*)+f'(\xi)(x-x^*)$$ 

para algún $\xi$ entre $x$ y $x^*$. Para lo anterior tenemos $f(x^*) = 0$, por ser una raíz. Multiplicamos la expansión por alguna constante $C$:

$$C f(x) = C f'(\xi)(x-x^*)$$

y añadiendo $x^*-x$ en ambos lados de la ecuación tenemos:

$$x^*-x+Cf(x)=(x^*-x)+Cf'(\xi)(x-x^*).$$

Reacomodando términos se obtiene:

$$x^*=x-Cf(x)-(1-Cf'(\xi))(x-x^*).$$

Aunque no conocemos la raíz $x^*$ ni el punto $\xi$, sabemos que ambos puntos pertenecen al dominio $X$. Por lo que podremos acotar ambos y obtener lo siguiente:

$$x^* \in x-Cf(x)-(1-CF'(X))(x-X) \equiv K(X,x,C)$$

*Resultado*: Hemos probado que cualquier cero $x^* \in x$ de $f$ esta acotado por los extremos del **operador de Krawczyk** $K(X,x,C)$, para cualquier $x \in X$ y una $C$ finita. Elegimos $x = m = \textrm{mid}(X)$ y $C=1/f'(m)$ $^{[1,2]}$.

Finalmente el operador de Krawcyk resulta:

\begin{equation}
K(X) = K(X,m,1/f'(m)) = m-\frac{f(m)}{f'(m)}-\frac{1-F'(X)}{f'(m)}[-r,r]
\end{equation}

Donde $r=\textrm{rad}(X)$. Dado un intervalo inicial $X_0$ donde buscamos una raíz $x^*$, definimos la secuencia de intervalos:

$$X_{k+1} = K(X_k) \cap X_k, \qquad k=0,1,2,...$$

como las **iteraciones de Krawczyk** de $X_0$. Sea $m_k = \textrm{mid}(X_k)$. Mientras $f'(m_k) \neq 0$ para toda $k \in \mathbb{N}$, se dice que la secuencia esta *bien definida*. De lo anterior, obtenemos el siguiente resultado.

**Teorema.** Suponiendo que $K(X)$ está bien definido, entonces los siguientes se cumple:

(1) si $X$ contiene una raíz $x^*$ de $f$, entonces el cero también está contenido en $K(X) \cap X$ ;

(2) si $K(X) \cap X = \emptyset$, entonces $X$ no contiene ceros; y

(3) si $K(X) \subseteq \textrm{int}(X)$, entonces $X$ contiene exactamente un cero, donde $\textrm{int}(X) = \{ x : \inf(X) < x < \sup(X) \}$.

**Código.** Llamamos *Krawczyk.jl* al módulo donde se implementa este método y se puede encontrar en https://github.com/rockopm/FCA-ProyectoFinal/blob/master/Krawczyk.jl.

En el módulo de `Krawczyk.jl` se construye la función `optimiza(X::Intervalo, f::Function, err)` que tiene como argumentos `X::Intervalo` que es el intervalo inicial con que se empieza la iteración de Krawczyk, `f::Function` que corresponde a la función que se desea optimizar, y `err` que es un valor de precisión con que deseamos el resultado aproximado. Esta función devuelve una *n-tupla* de la forma

$$(y^*, X^*),$$

donde $y^*$ es el valor mínimo de la función $f$ y $X^*$ es el intervalo en el dominio donde se encuentra el punto $x^*$ tal que $y^* = f(x^*)$.

## Módulos

###Derivadas.jl

Utilizamos el hecho de que las si $x^*$ es mínimo de $f$ entonces $f'(x^*) = 0$. De esta forma, utilizamos el método de Krawczyk en las derivada de la función $f$ para encontrar los mínimos en un intervalo $X$ de $f$.

Para usar la derivada de una función $f$ dada por el usuarios, sin que dicha derivada se especifíque explícitamente, usamos una extensión del módulos `Derivadas.jl` desarrollado en clase.

En aquella ocasión, en el notebook 6, desarrollamos un módulo que permitía evaluar funciones en un objeto denominado `Derivada(x, x')` en donde se obtenía como resultado un objeto del mismo tipo `Derivada(f, f')` donde `f` es la función $f$ evaluada en el punto $x$ y `f'` es su derivada evaluada en el mismo punto.

Para este trabajo, extendemos el módulo para que este contenga también la segunda derivada de la función, obteniendo como resultados objetos del tipo `Derivada(f,f',f'')`.

**Código.** Éste módulo lo llamamos *Derivadas.jl* y se puede obtener en https://github.com/rockopm/FCA-ProyectoFinal/blob/master/Derivadas.jl.


### Intervalos.jl

Para utilizar intervalos como argumento de las funciones a utilizar, mejoramos a detalle el módulo `Intervalos.jl` hecho en clase. Utilizamos teoremas derivados de la artimética de intervalos para definir el intervalo vacío y las operaciones aritméticas de suma, resta, multiplicación y división $^{[3]}$.

La implementación del módulo y los detalles de las matemáticas relacionadas se pueden encontrar en https://github.com/lbenet/MetodosNumericosAvanzados/blob/master/notebooks en el notenook 7.

**Código.** Llamamos *Intervalos.jl* al módulo dedicado a la aritmética de intervalos, y este lo puedes encontrar en https://github.com/rockopm/FCA-ProyectoFinal/blob/master/Intervalos.jl.
