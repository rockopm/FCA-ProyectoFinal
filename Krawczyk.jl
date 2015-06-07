module Krawczyk

using Derivadas
using Intervalos

export KrawOp, verifica_KrawOp, divide, hayraices, eleccionIntervalos, tol, optimiza

## Calcula operador de Krawczyk

function KrawOp(X::Intervalo, f::Function)
	m = mid(X)
	r = rad(X)
	DX = Derivada(X,Intervalo(1,1),Intervalo(0,0))
	dm = Derivada(m,1,0)
	return m - f(dm).dif/f(dm).ddif - (1 - f(DX).ddif/f(dm).ddif)*Intervalo(-r,r)
end

## Verifica si el operador K esta bien definido, es decir, si f'(m) NO ES CERO, y modifica el intervalo.

function verifica_KrawOp(f::Function, X::Intervalo)
	m = mid(X)
	macheps = eps(BigFloat)
#	if typeof(f(Derivada(m,1,0))) != Derivada
#		return X
#	else
	if f(Derivada(m,1,0)).ddif == 0
		return Intervalo(X.a - macheps, X.b + macheps)
	else
		return X
	end
end

## Funcion que bisecciona el intervalo X

function divide(X)   # Puede dividir en mas de dos intervalos
	m = mid(X)
	return (Intervalo(X.a, m), Intervalo(m,X.b))
end

## Verifica si hay raices o no

function hayraices(X::Intervalo, K::Intervalo)
	Xk = intersect(X,K)
	if isempty(Xk)
		return false
#	elseif (X.a < K.a) & (K.b < X.b)
#		return true
	else
		return true
	end
end

## Proceso del metodo de Krawczyk

function eleccionIntervalos(raices::Array{Intervalo,1}, f::Function)
	candidatos = Intervalo[]
	eliminados = Intervalo[]
	for i = 1:length(raices)
		K = KrawOp(raices[i], f)
		if hayraices(raices[i],K)
			Xk = intersect(raices[i], K)
			(XLeft, XRight) = divide(Xk)
			push!(eliminados,raices[i])
			if hayraices(XLeft, KrawOp(XLeft,f))
				push!(candidatos,XLeft)
			end
			if hayraices(XRight, KrawOp(XRight,f))
				push!(candidatos,XRight)
			end
		else
			push!(eliminados,raices[i])
		end
	end
	candidatos
end

function tol(raices::Array{Intervalo,1}, err)
	b = true
	for i = 1:length(raices)
		b = b & (long(raices[i]) < err)
	end
	return b
end

function optimiza(X::Intervalo, f::Function, err)
	if typeof(f(X)) != Intervalo  # cte(x) = c aqui c es un real
		return X
	end
	if (Derivada(f(X)).ddif.a == 0) & (Derivada(f(X)).ddif.b == 0)
		mincte = min(f(X.a), f(X.b))
		return Intervalo(mincte, mincte)
	end
	X = verifica_KrawOp(f,X)
	raices = Intervalo[X]
	while ~tol(raices, err)
		raices = eleccionIntervalos(raices,f)
	end
	n = length(raices)
	result = Intervalo[]
	if n > 1
		for i = 1:n-1
			I = intersect(raices[i], raices[i+1])
			if isempty(I)
				push!(result,raices[i])
			else
				push!(result,I)
			end
		end
		I = intersect(raices[n-1], raices[n])
		if isempty(I)
			push!(result,raices[n])
		end
	else
		result = raices
	end
	if isempty(result)
		if min(f(X.a),f(X.b)) == f(X.a)
			return Intervalo(X.a,X.a)
		else
			return Intervalo(X.b,X.b)
		end
	else
		return result
	end
end

end
