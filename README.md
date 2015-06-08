*Maestría en Ciencias Físicas: Física Computacional Avanzada*

---

# Código para encontrar rigurosamente el mínimo de una función en un intervalo

**Christian Marchen (1), Rodrigo Pineda Mondragón (2)**

(1) Maestría en Ciencias Matemáticas, IIMAS, UNAM. GitHub: hierro40
(2) Maestría en Ciencias Matemáticas, IIMAS, UNAM. GitHub: rockopm

---

*
**Abstract: ** El problema de optimización de funciones es ubicuo en el mundo de las matemáticas aplicadas. La física, las finanzas, la biología, las ecuaciones diferenciales y demás ciencias que utilizan las matemáticas como herramienta de estudio convergen en algún punto en algún problema de optimización. Además, la complejidad de los nuevos modelos matemáticos desarrollados en estas ciencias nos obligan a hacer uso de herramientas computacionales cuando estos carecen de soluciones en forma cerradas. Existen métodos numéricos desarrollados para resolver el problema de encontrar el mínimo de una función dada una aproximación inicial, pero la mayoría de estos arrojan soluciones que dependen de esta primera aproximación dada por el usuario. Sin embargo, los métodos para encontrar raíces de funciones han sido extendidos para utilizar intervalos como aproximación inicial, en vez de puntos, por lo que el hecho de que $f'(x) = 0$ implique un punto crítico de $f$ nos ayuda a mejorar estos métodos para encontrar raíces de la derivada de esta función y así concluir si es un mínimo o no. En este trabajo desarrollamos un código rigusoro basado en el **método de Krawczyk** para encontrar los mínimos de una función en un intervalo dado por el usuario. Utilizamos un catálogo de **funciones suaves** para mostrar la efectividad del método.*

## Método de Krawczyk

El **método de Krawczyk** es una alternativa al método de Newton para encontrar ceros de funciones, pues Krawczyk evita los problemas de dividir entre un intervalo cuando estamos haciendo las iteraciones del método de Newton. 

**Código.** Llamamos *Krawczyk.jl* al módulo donde se implementa este método y se puede encontrar en https://github.com/rockopm/FCA-ProyectoFinal/blob/master/Krawczyk.jl.

En el módulo de `Krawczyk.jl` se construye la función `optimiza(X::Intervalo, f::Function, err)` que tiene como argumentos `X::Intervalo` que es el intervalo inicial con que se empieza la iteración de Krawczyk, `f::Function` que corresponde a la función que se desea optimizar, y `err` que es un valor de precisión con que deseamos el resultado aproximado. Esta función devuelve una *n-tupla* con el infimo de la función en la primer entrada y con el intervalo en el dominio donde se encuentra infimo.

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
