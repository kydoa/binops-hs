-- Exercicio 1)

--Definir uma função recursiva que recebe um número binário (interpretado como número inteiro sem sinal) e
--retorna o valor equivalente em decimal.

bin2dec :: [Bool] -> Int
bin2dec []     = 0
bin2dec (b:bs) = (if b then 1 else 0) * (2 ^ length bs) + bin2dec bs

--EXEMPLOS USO

-- bin2dec [True, False, True] = 5
-- bin2dec [True, True, True] = 7
-- bin2dec [] = 0

-- Exercicio 2)

--Definir uma função recursiva que recebe um número decimal inteiro não-negativo, um número de bits
--desejado e retorna o valor equivalente em binário (interpretado como número inteiro sem sinal) com o
--número de bits informado. Caso o número de bits não seja suficiente, escolha uma forma adequada de lidar
--com a situação, por exemplo, usando truncamento ou mensagem de erro. Por exemplo, 𝑑𝑒𝑐2𝑏𝑖𝑛 2 8 deve
--retornar [False, False, False, False, False, False, True, False].

dec2bin :: Int -> Int -> [Bool]
dec2bin _ 0 = []
dec2bin n bits = dec2bin (n `div` 2) (bits - 1) ++ [n `mod` 2 == 1]

--EXEMPLOS USO

--dec2bin 2 8 = [False,False,False,False,False,False,True,False]
--dec2bin 6 4 = [False,True,True,False]
--dec2bin 5 0 = []

-- Exercicio 3)

--Definir uma função recursiva que recebe um número binário na representação de complemento de dois e
--retorna o valor equivalente em decimal inteiro.

bincompl2dec :: [Bool] -> Int
bincompl2dec []     = 0
bincompl2dec (x:xs) = aux (if x then -1 else 0) xs
  where
    aux acc []     = acc
    aux acc (b:bs) = aux (acc * 2 + if b then 1 else 0) bs

--EXEMPLOS USO

--bincompl2dec [True, True, True, True, True, True, True, False] = -2
--bincompl2dec [False, True, True] = 3
--bincompl2dec [True] = -1

-- Exercicio 4)

--Definir uma função recursiva que recebe um número decimal inteiro, um número de bits desejado e retorna
--o valor equivalente em binário na representação de complemento de dois com o número de bits informado.
--Caso o número de bits não seja suficiente, escolha uma forma adequada de lidar com a situação, por
--exemplo, usando truncamento ou mensagem de erro. Por exemplo, 𝑑𝑒𝑐2𝑏𝑖𝑛𝑐𝑜𝑚𝑝𝑙 (−2) 8 deve retornar
--[True, True, True, True, True, True, True, False]. 

dec2bincompl :: Int -> Int -> [Bool]
dec2bincompl n bits = dec2bin' val bits
  where
    val = if n < 0 then n + (2 ^ bits) else n
    dec2bin' _ 0 = []
    dec2bin' x b = dec2bin' (x `div` 2) (b - 1) ++ [x `mod` 2 == 1]

--EXEMPLOS USO

--dec2bincompl (-2) 8 = [True, True, True, True, True, True, True, False]
--dec2bincompl 3 6 = [False, False, False, False, True, True]
--dec2bincompl 5 0 = []

-- Exercicio 5)

--Definir uma função recursiva que recebe dois números binários na representação de complemento de dois e
--um número de bits, retornando a soma binária destes valores considerando o limite de bits informado. A
--função deve assumir que: (i) os operandos possuem exatamente o número de bits indicado; (ii) o resultado
--também deve possuir exatamente esse número de bits. Além disso, a função deve indicar se ocorreu
--overflow durante a operação. A função deve retornar uma tupla no formato:
--(resultado, overflow), onde: (i) resultado é o número binário resultante da soma; (ii) overflow é um valor 
--booleano que indica se houve estouro de capacidade.

somarBin :: [Bool] -> [Bool] -> Int -> ([Bool], Bool)
somarBin a b bits = 
    let 
        revRes = addRev (reverse a) (reverse b) False
        resBits = reverse (take bits revRes)
        aMsb   = head a
        bMsb   = head b
        resMsb = head resBits
        overflow = (aMsb == bMsb) && (resMsb /= aMsb)
    in (resBits, overflow)
  where 
    addRev [] [] False = []
    addRev [] [] True  = [True]
    addRev (x:xs) (y:ys) c = 
        let 
            count = (if x then 1 else 0) + (if y then 1 else 0) + (if c then 1 else 0)
            bitRes = count `mod` 2 == 1
            nextC  = count >= 2
        in bitRes : addRev xs ys nextC

--EXEMPLOS USO

--somarBin [False, False, True, False] [False, False, True, True] 4 = ([False, True, False, True], False)
--somarBin [False, False, True, False] [False, False, True, True] 3 = ([False, True, True], True)
--somarBin [False, True, False, True] [False, True, False, True] 4 = ([True, False, True, False], True)