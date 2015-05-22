module Krawczyk

using Derivadas
using Intervalos

export KrawOp, verifica_KrawOp, divide, hayraices, eleccionIntervalos, tol, ceros

#function KrawOp(X::Intervalo, f::Function, df::Function)
#	m = mid(X)
#	r = rad(X)
#	return m - f(m)/df(m) - (1 - df(X)/df(m))*Intervalo(-r,r)
#end

## Calcula operador de Krawczyk

function KrawOp(X::Intervalo, f::Function)
	m = mid(X)
	r = rad(X)
	DX = Derivada(X,Intervalo(1,1),Intervalo(0,0))
	dm = Derivada(m,1,0)
	return m - f(m)/f(dm).dif - (1 - f(DX).dif/f(dm).dif)*Intervalo(-r,r)
end

## Verifica si el operador K esta bien definido, es decir, si f'(m) NO ES CERO, y modifica el intervalo.

function verifica_KrawOp(f::Function, X::Intervalo)
	m = mid(X)
	macheps = eps(BigFloat)
	if f(Derivada(m,1,0)).dif == 0
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
	#raices = Intervalo[X]
	candidatos = Intervalo[]
	eliminados = Intervalo[]
	for i = 1:length(raices)
		K = KrawOp(raices[i], f)
		if hayraices(raices[i],K)
			Xk = intersect(raices[i], K)
			(XLeft, XRight) = divide(Xk)
			push!(eliminados, raices[i])
			push!(candidatos,XLeft)
			push!(candidatos,XRight)
		else
			push!(eliminados,raices[i])
		end
	end
#	return raices
#	raices = union(setdiff(raices,eliminados), candidatos)
	candidatos
end

function tol(raices::Array{Intervalo,1}, err)
	b = true
	for i = 1:length(raices)
		b = b & (long(raices[i]) < err)
	end
	return b
end

function ceros(X::Intervalo, f::Function)
	X = verifica_KrawOp(f,X)
	raices = Intervalo[X]
	while ~tol(raices, 2.0^(-10))
		raices = eleccionIntervalos(raices,f)
	end
	return raices
end

end
