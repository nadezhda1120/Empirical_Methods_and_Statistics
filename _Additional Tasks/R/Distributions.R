#	Разпределения

#	d- изчислява вероятността за сбъдване на събитието x
#	p- изчислява вероятността на предварително зададен квантил за разпределението
#	q- изчислява квантилът на предварително зададена вероятност за разпределението
#	р- генерира случаини величини за дадено разпределение

# 	p- е обратна функция на q-. Например:

pnorm(q = .9, mean = 0, sd = 1)
# [1] 0.8159399 
qnorm(pnorm(q = .9, mean = 0, sd = 1))
# [1] 0.9

# 1. Биномно разпределение.
# 	Биномното разпределение е дискретно разпределение, което брои успехите в 
#	редица от n независими опити. Биномното разпределение приема параметри 
#	"n"-броя на опитите и "p"-вероятността за настъпване на успех.
#	Вероятността за настъпване на събитие "x" e P(x=k)=C(n, k).p^k.(1-p)^{n-k}
# 	В R функциите за биномно разпределение са rbinom(), dbinom(), pbinom(), qbinom().
#	"n"-броя на симулациите, "size"-големината на редицата от независими опити, "p"-
#	вероятността за настъпване на успех от един опит.
#	Частният случай, когато n=1 поражда Бернулиево разпределение. Т.е. искаме да
#	генерираме само един опит с вероятност за успех "p".

rbinom(n = 1, size = 1, p = .2)
# [1] 0

rbinom(n = 10, size = 1, p = .2)
# [1] 0 0 0 1 0 0 1 0 0 0

#	Нека си направим следния експеримент. Представете си, че играете игра, в която от 
#	кутия с четири черни и една бяла топка вадите по случаен начин една тoпка пет пъти #	като след всяко изваждане връщате топката.
#	Нека събитието УСПЕХ={и петте извадени топки са се оказали бели}
#	a) От изиграни 1000 такива игри и изведете номерата на игрите, чиито изход е бил
#	УСПЕХ
#	b) Каква е вероятността от всички 1000 изиграни игри в а), в нито една да не е имало 
#	изход с УСПЕХ.

# a)
sol5of5 = function(k = 1000){
    for(i in 1:k){
        try = rbinom(n = 1, size = 5, p = .2)
        if(try == 5){
            print(paste(i, "-th try gave 5 successes", sep=""))
        }
    }
}
sol5of5()

# b)
dbinom(x = 0, size = 1000, p = .2 ** 5)
# [1] 0.7261119

pbinom(q = 0, size = 1000, p = .2 ** 5)
# [1] 0.7261119

# Средната стойност e равнa на size*p, където "size" и "p" са броят на опитите в редицата 
# от експерименти и вероятността за успех. Вариацията е равна на size*p*(1-p)

set.seed(2020)
rbd = rbinom(n = 1000, size = 6, p = .2)
summary(rbd)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#   0.000   0.000   1.000   1.168   2.000   5.000 
m = mean(rbd); m
# [1] 0.168
v = var(rbd); v
# [1] 0.9727487
diff.mean = m - 6 * .2; diff.mean
# [1] -0.032
diff.var = v - 6 * .2 * .8; diff.var
# [1] 0.01274875

# Вероятността програмист завършил КН във ФМИ да слуша чалга е 3%. Компания от 10
# програмисти завършили ФМИ със специалност КН са поканени на рожден ден в
# заведение което се слуша чалга. Каква е вероятността:
# а) само един от тях да хареса музиката?
# b) не-повече от 3 от тях да харесат музиката?
# c) между 2 и 4 (включително) от тях да харесат музиката
# d) поне трима от тях да харесат музиката?

p = .03; n = 10; k = 1
# a)
dbinom(x = k, size = n, prob = p)
# [1] 0.2280693

# b)
sol.b = function(){
    ans = 0
    for(k in 0:3){
        ans = ans + dbinom(x = k, size = n, prob = p)
    }
    print(ans)
} 
sol.b()
# [1] 0.9998529

pbinom(q = 3, size = n, prob = p)
# [1] 0.9998529

1 - pbinom(q = 3, size = n, prob = p, lower.tail = F)
# [1] 0.9998529

# c)
sol.c = function(){
    ans = 0
    for(k in 2:4){
        ans = ans + dbinom(x = k, size = n, prob = p)
    }
    print(ans)
}
sol.c()
# [1] 0.03450116

pbinom(q = 4, size = 10, prob = p) - pbinom(q = 1, size = 10, prob = p)
# [1] 0.03450116

1 - (pbinom(q = 1, size = 10, prob = p) + pbinom(q = 4, size = 10, prob = p, lower.tail = F))
# [1] 0.03450116


# d)
1 - pbinom(q = 2, size = n, prob = p)
# [1] 0.002764949

pbinom(q = 2, size = n, prob = p, lower.tail = F)
# [1] 0.002764949

# 2. Геометрично разпределение.
# 	Геометричното разпределение е дискретно разпределение, което брои неуспехите 
# 	до настъпване на успех. Притежава свойството безпаметност, т.е. каквато и да е
#	информация за досегашни изходи от експеримента, не променят вероятността за
#	успех. Иначе казано - не може да се изгради стратегия на база предходни събития. 
#	Вероятността за настъпване на събитие "x" е P(x=k)=p*(1-p)^k, za k=0, 1, ..., n, ...
#	неуспеха преди да е настъпил успех.
#	В R функциите за геометрично разпределение са rgeom(), dgeom(), pgeom(), qgeom().
#	"n"-броя на симулациите, "size"-големината на редицата от независими опити, "p"-
#	вероятността за настъпване на успех от един опит.
#	Частният случай, когато n=1 поражда Бернулиево разпределение. Т.е. искаме да
#	генерираме само един опит с вероятност за успех "p".

# Средната стойност e равнa на 1/p (с успеха) или (1-p)/p (без успеха), където "p" e вероятността за успех. 
# Вариацията е равна на (1-p)/p^2

set.seed(2020)
rgd = rgeom(n = 1000, prob = .2)
summary(rgd)
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#  0.000   1.000   3.000   4.276   6.000  46.000 
var(rgd)
# [1] 24.14397

# Вероятността играч на дартс да уцели централния сектор е 20%. Каква е вероятността:
# a) Каква е вероятността играча да уцели централния сектор на третата стрелба по
# мишената?
# b) Каква е вероятността играча да има между 5 и 8 неуспешни попадения включително?
# c) Каква е вероятността играча да не уцели централния сектор поне 6 пъти?
# d) Колко неуспеха ще са ни необходими, за да покрием вероятност от 80% за уцелване
# на централния сектор?

p = .2
# a)
# l losses before win
l = 2
dgeom(x = l, prob = p)
# [1] 0.128

# b)
sol.b = function(){
    ans = 0
    for(k in 5:8){
        ans = ans + dgeom(x = k, prob = p)
    }
    ans
}
ans = sol.b(); ans
# [1] 0.1934623

pgeom(q = 8, prob = p) - pgeom(q = 4, prob = p)
# [1] 0.1934623

1 - (pgeom(q = 4, prob = p) + pgeom(q = 8, prob = p, lower.tail = F))
# [1] 0.1934623
# c)

sol.c = function(){
    ans = 0
    for(k in 0:5){
        ans = ans + dgeom(x = k, prob = p)
    }
    print(1 - ans)
}
sol.c()
# [1] 0.262144

1 - pgeom(q = 5, prob = p)
# [1] 0.262144

pgeom(q = 5, prob = p, lower.tail = F)
# [1] 0.262144

# d)
qgeom(p = .8, prob = p)
# [1] 7
# 7 неуспеха преди успешното хвърляне покриват 80%, т.е. общо 8 хвърляния за да уцелим
# с вероятност 80%. 

# 3. Отрицателно биномно разпределение.
# 	Отрицателното биномно разпределение е дискретно разпределение, което брои
#	неуспехите до настъпване на "r" на брой успехи. Разпределението има два 
#	параметъра: "r" (броя на успехите) и "p" (вероятността за успех за всеки опит).
#	От тази дефиниция автоматично следва, че геометричното разпределение е частния 
#	случай на отрицателно биномно, за което r=1. 

# Тегловата функция (функцията на масата / вероятността за настъпване на събитие) е 
# P(x=k) = C(k+r-1, k)*(1-p)^r*p^k, за k = 0, 1, ...
# Очакването (средната стойност) е равнo на p*r/(1-p)
# Вариацията е r*(1-p)/p^2

# Проверка за твърдението с частния случай:
p = .2
qnbinom(p = 0.8, size = 1, prob = p)
# [1] 7
qgeom(p = 0.8, prob = p)
# [1] 7

set.seed(2020)
N = 1000
rnbd = rnbinom(n = N - 3, size = 3, prob = .2)
# size - броят на успехите
summary(rnbd)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#   0.00    6.00   10.00   11.62   16.00   53.00
var(rnbd)
# [1] 60.59408
hist(nbd)

# Петролна компания има 20% шанс да попадне на петролен кладенец при сондиране. 
# каква е вероятността компанията да пробие 7 кладенци, за да удари нефт 3 пъти?

r = 3; p = .2; n = 7 - r
dnbinom(x = n, size = r, prob = p)
# [1] 0.049152

# simulated
mean(rnbinom(n = 10000, size = r, prob = p) == n)
# [1] 0.0508

# Какъв е очакваният брой опити за постигане на 3 успеха, когато вероятността на успех е 
# 20%

r = 3; p = .2
# mean
# exact
r / p
# [1] 15
# simulated
mean(rnbinom(n = 10000, size = 3, prob = p)) + r
# [1] 15.0593

# Variance
# exact
r * (1 - p) / p^2
# [1] 60

# simulated
var(rnbinom(n = 100000, size = r, prob = p))
# [1] 59.50744


# 4. Поасоново разпределение.
# 	Поасоновото разпределение е дискретно разпределение, което брой събитията, #	които настъпват с вероятност "lambda" (n*p) за определен интервал от време. # 	При Поасоновото разпределение "n" клони към безкрайност, а "p" клони към 0. #	Връзката между поасоново и биномно разпределение е такава, че за n>100 и n*p<20 #	поасоновата оценката за събитие е много добро приближение за биномната оценка #	на същото това събитие: X~Bi(n,p)=approx. X~Poi(n*p).

# Тегловата функция на поасоновото разпределение е P(x = k) = exp(-lambda)*lambda^k/(k!), 
# lambda>0 и k=0, 1, 2, ...
# Очакването (средната стойност) и вариациата са равни на lambda = n*p
# Вариацията е r*(1-p)/p^2

set.seed(2020)
rpd <- rpois(n = 100, lambda = 3.4)
summary(rpd)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#    0.0     2.0     3.0     3.4     4.0     9.0 
var(rpd)
# [1] 3.252525

# За един час в Paradise Center влизат 1000 човека. Вероятността за покупка на стока от посетител е 1%.

# а) Каква е вероятността точно 10 клиента да си закупят нещо?
# b) Каква е вероятността поне 20 клиенти да си закупят нещо? # c) Каква е вероятността между 20 и 30 клиента (вкл.) да си закупят нещо?
# d) При вероятност от 3%, колко е максималния брой на закупени стоки?

n = 1000; p = .01

# a)
dpois(x = 10, lambda=n * p)
# [1] 0.12511

# b)
ppois(q = 19, lambda = n * p, lower.tail=F)
# [1] 0.003454342

1 - ppois(q = 19, lambda = n * p)
# [1] 0.003454342
# Забележете, че при дискретните разпределения, когато искаме да изследваме # вероятност от типа P(x >= k), винаги взимаме (x-1)

c)
sol.c = function(){
    ans = 0
    for(k in 20:30){
        ans = ans + dpois(x = k, lambda = n * p)
    }
    print(ans)
}
sol.c()
# [1] 0.003454262

ppois(q = 30, lambda = n * p) - ppois(q = 19, lambda = n * p)
# [1] 0.003454262

1 - (ppois(q = 19, lambda = n * p) - ppois(q = 30, lambda = n * p, lower.tail = F))
# [1] 0.003454422

d)
qpois(p = .03, lambda = n * p)
# [1] 5

# 5. Равномерно непрекъснато разпределение.
# 	Равномерното непрекъснато разпределение много наподобява равномерното
#	дискретно. Разликата е в това, че вместо дискретни стойности, при непрекъснатото
#	се приемат стойности в целия интервал.
#	Вероятността P(x < k) = (x - a) / (b - a).

#	Равномерното непрекъснато разпределение приема параметри a и b, които са
#	минимална и максимална стойности.

#	Генерирането на равномерно разпределение става с функцията 
#	runif(n, min = a, max = b)

runif(1, 0, 2)
# [1] 0.7570808
runif(5, 0, 2)
# [1] 1.8766972 0.4334253 0.3798865 0.6352569 0.6739561

set.seed(2020)
x <= runif(1000) # get the random numbers
hist(x, prob = T, breaks = 10)
zz <- runif(n = 100000, min = 1, max = 5)

# 6. Нормално разпределение.
# 	Нормалното разпределение е непрекъснато разпределение, което има два основни #	параметъра mu (средна стойност) и sigma (стандартно отклонение).

set.seed(2020)
rnd = rnorm(n = 1000, mean = 3, sd = 4)
summary(rnd)
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -9.6645  0.1479  2.7699  2.8933  5.5542 17.8116 
var(rnd)
# [1] 17.20475

# Нормалното разпределение е камбановидно

# Пчеларят Иван по някакъв начин и измислил скала, измерваща полезността на пчелите 
# си. Иван забелязал, че средната стойност на ефективността на печелите е 7, а 
# стандартното отклонение е 1.5.

# а) Каква е вероятността една пчела да има оценка поне 9 по скалата му за ефективност?
# b) Каква е вероятността една пчела да има оценка между 5 и 9 включително?

mu = 7
sigma = 1.5
# a)
pnorm(q = 9, mean = mu, sd = sigma, lower.tail = F)
# [1] 0.09121122
1 - pnorm(q = 9, mean = mu, sd = sigma)
# [1] 0.09121122

# b)
pnorm(q = 9, mean = mu, sd = sigma) - pnorm(q = 5, mean = mu, sd = sigma)
# [1] 0.8175776
1 - (pnorm(q = 5, mean = mu, sd = sigma) + pnorm(q = 9, mean = mu, sd = sigma, lower.tail = F))
# [1] 0.8175776

# Всяко едно нормално разпределение, с очакване "mu" и стандартно отклонение 
# "sigma", може да се стандартизира в нормално разпределение с очакване 0 и стандартно 
# отклонение 1. Стандартизацията се нарича Z-score, а формулата е 
# Z = (x - mean(x)) / sd(x)

rnd1 = (rnd - mean(rnd)) / sd(rnd)

# R притежава функция "scale", която го прави автоматично. Функцията приема 
# параметрите "center" (булева или числова променлива) и "scale" (булева или числова 
# променлива)

rnd2 = scale(rnd)

all(rnd1 == rnd2) # Проверяваме дали всички стойности на rnd1 и rnd2 са равни
# [1] TRUE

# 7. Експоненциално разпределение.
# 	Друго важно непрекъснато разпределение е екопоненциалното. Това
#	разпределение e подходящо за употреба в случаи, когато имаме работа с
#	промеливи, свързани с време.
# 	Експоненциалното разпределение има само един параметър lambda.
#       	Експоненциалното разпределение се свързва с Поасоновото разпределение и с 
#	него се оценява времето между настъпванията на две събития. Това разпределение 
#	се разглежда и като непрекъснат аналог на геометричното разпределение.
#       	Средната стойност на експоненциалното разпределение е равна на 1/lambda
#   	Вариацията = 1/lambda^2.

set.seed(2020)
lambda = 4
red = rexp(1000, rate = 1/lambda)
hist(red)

summary(red)
#     Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
# 0.002478  1.229913  2.929320  4.221640  5.652619 27.744544 
var(red)
# [1] 18.12082

# 8. t разпределение.
#	Друго важно непрекъснато разпределение е t разпределението. Това 
#	разпределение се използва за оценка на параметрите на популацията, когато 
#	размерът на извадката е малък или когато стандартното отклонение на популацията 
#	е неизвестно. T разпределениетo има един параметър nu = n - 1 (n - броят на 
#	наблюденията), който представлява степените на свобода.
#	Средната стойност и медианата на t разпределението са 0, а вариацията nu/(nu-2)

set.seed(2020)
df = 14
td = rt(10^4, df = df)
hist(td)
 
summary(td)
#     Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
# -5.722198 -0.711701 -0.012846 -0.006796  0.684911  5.151971 
var(td)
# [1] 1.174868

# 9. Chi квадрат разпределение
#	Chi квадрат разпределението е непрекъснато разпределение, което представлява 
#	сума на k на брой независими стандартно нормално разпределени величини. 	\
#	Използваме го за тестване на хипотези свързани с дисперсията и при определяне 
#	на доверителните интервали. Разпределението намира приложение и при 
#	изследването на категорийните модели и по-точно до колко прогнозите на един 
#	модел съответстват на реалните стойности.

#	Разпределенеито има един параметър (k), показващ степените на свобода.
#	Oчакването на Chi квадрат е k, а дисперсията e 2*k.

set.seed(2020)
N = 1000
rch = rchisq(n = N, df = 30)
hist(rch)
 
summary(rch)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#  11.35   24.42   29.13   29.84   34.49   64.21 
var(rch)
# [1] 59.66219

# 10. Хипергеометрично разпределение
#	Това е дискретно разпределение, което описва вероятността от k успеха в n мерна 
#	извадка, без замествания, взета от крайна популация с размер N и съдържаща K на 
#	брой успеха. Разпределението намира приложение при изследването дали една 
#	популация е overrepresented или underrepresented.
#	Тегловата функция е P(x) = C(K, k)*C((N - K), (n - k)) / C(N, n)
#	Очакването е n*K/N, а вариацията - n*(K/N)*((N-K)/N)*((N-n)/(N-1))

# 11. Boostrap
#	Booostrap е метод, който представлява създаване на извадка с големина, равна на 
#   	големината на вектора X и всеки елемент от X може да участва пвоече от веднъж в #	новата извадка. 

data(faithful)
names(faithful)
# [1] "eruptions" "waiting"  

eruptions = faithful[, "eruptions"]
sample(eruptions, 10, replace = TRUE)
# [1] 1.817 1.817 1.800 3.733 1.600 4.033 4.150 4.417 2.317 4.500
 
par(mfrow = c(1, 2))
hist(eruptions, breaks = 25)
hist(sample(eruptions, length(eruptions), replace = TRUE), breaks = 25)
par(mfrow = c(1, 1))

# Едно от приложенията на bootstrap метода е при определянето на локацията на 
# разпределение с тежки опашки и/или изразена асиметрия. Целта е да се включат в 
# анализа и наблюдения, които се считат за "outlier"-и.


#       Асиметрия

# За да видим дали имаме асиметрия в разпределението, ще изчислим статистиката 
# skewness. В R има доста пакети, които предлагат тази опция ("DistributionUtils", "fBasics", 
# "moments", "e1071"), но за целта ще използваме наша собствена

Skewness = function(x) {
	x_centred = x - mean(x)
	n = length(x_centred)
	y = sqrt(n)*sum(x_centred^3) / (sum(x_centred^2)^(3/2))
	list(estim = y*((1 - 1/n))^(3/2), se = sqrt((6*n*(n-1)) / (n-2) / (n+1) / (n+3)))
}

N = 1000
set.seed(2020)
x1 = -rexp(N, rate = 1/3); x1_skewness = Skewness(x1)
x3 = rgamma(N, shape = 2, rate = 1/6); x3_skewness = Skewness(x3)
x2 = rnorm(N, mean = 4, sd = 3); x2_skewness = Skewness(x2)

par(mfrow = c(1, 3))
hist(x1, xlab = "rexp Values", main = paste("Skewness:", round(x1_skewness$estim, 3)), col = "red")
hist(x2, xlab = "rgamma Values", main = paste("Skewness:", round(x2_skewness$estim, 3)), col = "forestgreen")
hist(x3, xlab = "rnorm Values", main = paste("Skewness:", round(x3_skewness$estim, 3)), col = "blue")
par(mfrow = c(1, 1))

# Лесно се забелязва, че при отрицателна стойност на skewness имаме асиметрия, при 
# която лявата опашка е по-дълга. И обратното - при положителна стойност имаме 
# по-дълга дясна опашка.
# Ако стойността е близка до 0, тогава нямаме доказана асиметрия в разпределението.
# Но какво означава, стойност близка до 0-та, при положение, че в статистиката разлика 
# от 10 може да бъде незначима, а разлика от 0.00001 да бъде?
# Това е така и ето защо има и начин за определянето на значимостта?
# Най-лесно съотношението abs(estim/se) трябва да бъде по-малко от 2

x1_skewness$estim / x1_skewness$se
# [1] -24.32162
x2_skewness$estim / x2_skewness$se
# [1] -0.3944342
x3_skewness$estim / x3_skewness$se
# [1] 21.33599

# Да се върнем към bootstrap алгоритъма за изчисляване на локацията на 
# разпределението. Той се състои в следните стъпки:
#   1. Определяме броя (M) на извадките (извадките са с повторения и имат дължина, равна 
#   на вектора, от който сме взели извадката).
#   2. Изчисляваме средната стойност на всички M извадки и ги съхраняваме в нов вектор.
#   3. От централната гранична теорема (ЦГТ, CLT) следва, че този вектор е с нормално 
#   разпределение.
#   4. Взимаме средната стойност на този вектор го приемаме за локация на 
#   разпределението, а с помощта на стандартното отклонение, можем да определоим 
#   доверителни интервали.

N = 400
set.seed(9504)
X = rgamma(n = N, shape = 2, rate = 1/20)
hist(X)
summary(X)
mean(X, trim = 0.05)

M = 500
Mat = matrix(nrow = M, ncol = length(X))
# Създаваме матрица, която има M на брой редове и length(X) брой колони
# В тази матрица, по редове ще съхраняваме извадките

set.seed(2020)
for(row_index in 1:nrow(Mat)) {
	Mat[row_index, ] <- sample(x = X, size = length(X), replace = TRUE)
}

# С долния ред взимаме всички средни стойности по редове
mu_array <- apply(Mat, 1, FUN = mean)

par(mfrow = c(1, 2))
hist(mu_array, main = "Histrogram of mu's distribution", xlab = "Values", col = "pink")

qqnorm(mu_array); qqline(mu_array)
par(mfrow = c(1, 1))

# Проверката на хипотези е важна част от анализа на данни. В сегашния случай ще
# проверим хипотезата, че разпределението е нормално. За целта ще използваме тест, 
# който проверява хипотезата.

shapiro.test(mu_array)

# Стойността p-value > 0.05 => разпределението може да го приемем за нормално.

summary(X)
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
# 0.5722  21.4236  33.2965  40.0716  52.3694 209.4419 
mean(X, trim = 0.05)
# [1] 37.13742
(loc <- mean(mu_array))
# [1] 40.07276

# Предимството на този тест е, че можем да определим някакви неблагоприятни 
# стойности, които да използваме вместо реалното очакване.
# Така например, ако искам в 95% от случаите да съм познал средната си стойност, тогава # взимам 5% квантил.

(a <- quantile(mu_array, prob = 0.05))
#      5% 
# 37.48079 

hist(mu_array, main = "Histrogram of mu's distribution", xlab = "Values", col = "orange")
abline(v = loc, lwd = 3, col = "blue")
abline(v = a, lwd = 3, lty = 3, col = "forestgreen")
