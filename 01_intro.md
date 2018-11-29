Les mathématiques confèrent aux humains une capacité d’abstraction
suffisamment complexe pour leur permettre de toucher les étoiles et les
atomes, d’assembler la pensée pour mieux apprécier l’histoire et de
prédire le futur, de toucher l’infini et de goûter à l’éternité. À
partir des maths, on a pu créer des outils de calcul permettent de
projeter des images de l’univers, bien au-delà de la Voie lactée. Mais
appréhender le vivant demeure néanmoins une tâche complexe.

En développant son jeu de la vie (*game of life*) en 1970, John Horton
Connway a présenté un exemple percutant que des règles simples peuvent
mener à des résultats innatendus. Le jeu consiste à placer des jetons
sur les cases d’un plateau de jeu consistant en une simple grille
othogonale. Le jeu évolue en fonction du nombre de jetons présents parmi
les huit cases du voisinage des jetons ou des cases vides.

1.  Les jetons ayant 0 ou 1 voisin sont retirés.
2.  Les jetons ayant 2 ou 3 voisins restent intacts
3.  Les jetons ayant plus de 3 voisins sont retirés
4.  Un jeton est posé sur les cases ayant exactement 3 voisins

C’est tout. Selon la manière dont les jetons sont placés au départ, il
se peut que la grille se vide de ses jetons, ou que les jetons y
prennent beaucoup de place. Il arrive aussi que des cycles réguliers se
dégagent ou que l’on se retrouve avec des formes régulières. Vous aurez
peut-être compris à ce stade pourquoi le jeu est appelé “jeu de la vie”.
La première règle est une situation localisée de sous-population,
condition dans laquelle la reproduction est difficile. La deuxième règle
est une situation localisée stable. La troisième est une situation de
surpopulation, où des individus meurent par un environnement rendu
inadéquat par insuffisance de ressource ou surplus de toxicité. Enfin,
la quatrième indique une situation favorable à la reproduction.

Une grille vidée correspond à une extinction et une grille remplie
correspond à une explosion de population. Une oscillation est un
“climax”, un état stable en écologie. Un léger changement initial dans
la disposition initiale des jetons peu mener à des solutions
différentes.

Le jeu, qui en fait est une application de la technique des *automates
cellulaires*, se complexifie à mesure que le nombre de jetons grandit.
Un humain passera des heures à calculer une itération à 50 jetons,
commettra probablement quelques erreurs et demandera quelques cafés. Un
processeur pourra gérer des centaines d’itérations sur des grilles de
centaines de jetons en quelques secondes.

En établissant des règles correspondant aux mécanismes de l’objet
étudié, il devient possible de modéliser l’évolution des systèmes
vivants, comme l’émergence d’espèces invasives.

<img src="https://media.giphy.com/media/dkaEYYiCDclAA/giphy.gif?response_id=5925bb98f431280237d48493" width=300>

Simulation avec automates cellulaires. Source: Anynyme, publié sur
[Giphy](https://giphy.com/gifs/misc-dkaEYYiCDclAA).

Définitions
===========

<img src="images/01_disciplines.png" width=280 style="padding:5px;">

Carte des domaines de l’écologie mathématique

L’écologie mathématique couvre un large spectre de domaines, mais peut
être divisée en deux branches: l’**écologie théorique** et l’**écologie
quantitative** (Legendre et Legendre, 2012). Alors que l’écologie
théorique s’intéresse à l’expression mathématique des mécanismes
écologiques, l’écologie quantitative, plus empirique, en étudie
principalement les phénomènes. La **modélisation écologique** vise à
prévoir une situation selon des conditions données. Faisant partie à la
fois de l’écologie théorique et de l’écologie quantitative, elle
superpose souvent des mécanismes de l’écologie théorique et des
phénomènes empiriques de l’écologie quantitative. L’**écologie
numérique** comprend la branche descriptive de l’écologie quantitative,
c’est-à-dire qu’elle s’intéresse à évaluer des effets à partir de
données empiriques. L’exploration des données dans le but d’y découvrir
des structures passe souvent par des techniques multivariées comme la
classification hiérarchique ou la réduction d’axe (par exemple,
l’analyse en composantes principales), qui sont davantage heuristiques
(dans notre cas, **bioheuristique**) que statistiques. Les tests
d’hypothèses et l’analyse des probabilités, quant à eux, relèvent de la
**biostatistique**.

Le **génie écologique**, une discipline intimement liée à l’écologie
mathématique, est vouée à l’analyse, la modélisation, la conception et
la construction de systèmes vivants dans le but de résoudre de manière
efficace des problèmes liés à l’écologie et à une panoplie de domaines
qui lui sont raccordés. L’agriculture est l’un de ces domaines. C’est
d’emblée la discipline qui sera prisée dans ce manuel. Néanmoins, les
principes qui seront discutés sont transférable à l’écologie générale.

À qui s’adresse ce manuel?
==========================

Le cours vise à introduire des étudiants gradués en agronomie, biologie,
écologie, sols, génie agroenvironnemental, génie civil et génie
écologique à l’analyse et la modélisation dans leur domaine, tant pour
les appuyer pour leurs travaux de recherche que pour leur fournir une
trousse d’outil émancipatrice pour leur cheminement professionnel. Plus
spécifiquement, vous serez accompagné à découvrir différents outils
numériques qui vous permettront d’appréhender vos données, d’en faire
émerger l’information et de construire des modèles. En ce sens, **c’est
un cours de pilotage, pas un cours de mécanique**.

Bien que des connaissances en programmation et en statistiques aideront
grandement les étudiant.e.s à appréhender ce document, une littératie
informatique n’est pas requise. Dans tous les cas, quiconque voudra
tirer profit de ce manuel devra faire preuve d’autonomie. Vous serez
guidés vers des ressources et des références, mais je vous suggère
vivement de développer votre propre bibliothèque adaptée à vos besoins
et à votre manière de comprendre.

Les logiciels libres
====================

Tous les outils numériques qui sont proposés dans ce cours sont des
logiciels libres:

> « Logiciel libre » \[free software\] désigne des logiciels qui
> respectent la liberté des utilisateurs. En gros, cela veut dire que
> les utilisateurs ont la liberté d’exécuter, copier, distribuer,
> étudier, modifier et améliorer ces logiciels. Ainsi, « logiciel libre
> » fait référence à la liberté, pas au prix1 (pour comprendre ce
> concept, vous devez penser à « liberté d’expression », pas à « entrée
> libre »). - [Projet
> GNU](https://www.gnu.org/philosophy/free-sw.fr.html)

Donc: codes sources ouverts, développement souvent communautaire,
gratuité. Plusieurs [raisons
éthiques](https://www.youtube.com/watch?v=Ag1AKIl_2GM), principalement
liées au contrôle de l’environnement virtuel par les utilisateurs et les
communautés, peuvent justifier l’utilisation de logiciels libres.
Plusieurs raisons pratiques justifient aussi cette orientation. Les
logiciels libres vous permettent de transporter vos outils avec vous,
d’une entreprise à l’autre, au bureau, ou à la maison, et ce, sans vous
soucier d’acheter de coûteuses licences.

On soulève avec justesse les risques liés aux possibles erreurs dans les
codes des logiciels communautaires. Pour les scientifiques, une erreur
peu mener à une étude retirée de la littérature et même,
potentiellement, des politiques publiques mal avisées. Pour les
ingénieurs, les conséquences pourraient être dramatiques. Mais retenez
qu’en toute circonstance, **comme professionnel.le, vous êtes
responsable des outils que vous utilisez: vous devez vous assurer de la
bonne qualité d’un logiciel, qu’il soit propriétaire ou communautaire**.

Alors que la qualité des logiciels propriétaires est généralement suivie
par audits, celle des logiciels libres est plutôt soumise à la vigilance
communautaire. Chaque approche a ses avantages et inconvénients, mais
elles ne sont pas exclusives. Ainsi les logiciels libres peuvent être
audités à l’externe par quiconque décide de le faire. Différentes
entreprises, souvent concurrentes, participent tant à cette vigilance
qu’au développement des logiciels libres: elles en sont même souvent les
instigatrices (comme [RStudio](https://www.rstudio.com/),
[Anaconda](https://www.anaconda.com/) et
[Enthought](https://www.enthought.com/)).

Par ailleurs, ce manuel est distribué librement (license [MIT](LIEN)).

Langage de programmation
========================

Ce manuel est créé dans un environnement intéractif de type *carnet de
notes* ([Jupyter lab](https://jupyter.org)). Ce format permet
d’intercaller des cellules de texte et des cellules de calcul.

R
-

Ce cours est basé sur le langage [R](https://www.r-project.org/). En
plus d’être libre, R est un langage de programmation dynamique
[largement utilisé dans le monde
universitaire](https://www.nytimes.com/2009/01/07/technology/business-computing/07program.html),
et dont l’utilisation s’étend de manière soutenue hors des tours
d’ivoire. Son développement est supporté par la [R Foundation for
Statistical Computing](https://www.r-project.org/foundation/), basée à
l’Université de Vienne. Également, l’équipe de
[RStudio](https://www.rstudio.com/) contribue largement au
[développement de modules
génériques](https://www.rstudio.com/products/rpackages/). R est
principalement utilisé pour le calcul statistique, mais les récents
développements le rendent un outil de choix pour tout ce qui entoure la
science des données, de l’interaction avec les bases de données au
déploiement d’outil d’intelligence artificielle en passant par la
visualisation. Une fois implémenté avec des modules de calcul
scientifique spécialisés en biologie, en écologie et en agronomie (que
nous couvrirons au long du cours), R devient un outil de calcul
convivial, rapide et fiable pour le calcul écologique.

Pourquoi pas Python?
--------------------

La première mouture de ce cous se fondait sur le langage `Python`. Tout
comme R, `Python` est un langage de programmation dynamique prisé pour
le calcul scientifique. `Python` est un langage générique apprécié pour
sa polyvalence et sa simplicité. `Python` est utilisé autant pour créer
des logiciels ou des sites web que pour le calcul scientifique. Ainsi,
Python peut être utilisé en interopérabilité avec une panoplie de
logiciels libres, comme [QGIS](http://www.qgis.org) pour la cartographie
et [FreeCAD](https://github.com/FreeCAD/FreeCAD) pour le dessin
technique. Il est particulièrement apprécié en ingénierie pour ses
modules de calcul par éléments finis
([FeNICS](https://fenicsproject.org/),
[SfePy](http://sfepy.org/doc-devel/index.html)) et en bioinformatique
pour ses outils liés au séquençage
([scikit-bio](http://scikit-bio.org/)), mais ses lacunes en analyse
statistique, en particulier en statistiques multivariées m’ont amené à
favoriser R.

Bien que leurs possibilités se superposent largement, ce serait une
erreur d’aborder R et `Python` comme des langages rivaux. Les deux
langages s’expriment de manière similaire et s’inspirent mutuellement:
apprendre à travailler avec l’un revient à apprendre l’autre. Les
spécialistes en calcul scientifique tendent à apprendre à travailler
avec plus d’un langage de programmation. Par ailleurs, l’enteprise [Ursa
labs](https://ursalabs.org/) travaille en ce moment à l’élaboration
d’une infrastructure de données permettant de partager des objets R et
Python, en vue d’intégrer différents langages de programmation dans un
même flux de travail.

Pourquoi pas Matlab?
--------------------

Parce qu’on est en 2018.

Pourquoi pas \_\_\_\_\_\_ ?
---------------------------

D’autres langages, comme [Julia](http://julialang.org),
[Scala](http://www.scala-lang.org),
[Javascript](https://dtabio.gitbooks.io/data-science-with-javascript/content/)
et [Ruby](http://sciruby.com) sont aussi utilisés en calcul
scientifique. Ils sont néanmoins moins garnis et moins documentés que R.
Des langages de plus bas niveau, comme Fortran et C++, viennent souvent
appuyer les fonctions des autres langages: ces langages sont plus ardus
à utiliser au jour le jour, mais leur rapidité de calcul est imbattable.

Comment utiliser ce manuel?
===========================

Le pire angle avec lequel je pourrais aborder le sujet, c’est avec du
code et des formules mathématiques. À travers chacun des chapitres, je
tenterai de vous amener à résoudre des problèmes de la manière la plus
intuitive possible.

**Décrire les chapitres ici**

Les chapitres 2, 3 et 4 peuvent être considérés comme fondamentaux pour
bien maîtriser R. Ils concernent respectivement les bases du langage R,
la manipulation de données et la visualisation. Si vous maîtrisez déjà
ces aspects, vous vous intéresserez davantage aux autres chapitres, qui
peuvent être consultés à la pièce.

Les chapitres de ce manuel sont composés dans un envronnement de travail
de type *notebook*, grâce à **Jupyter lab**. Pour exécuter les
commandes, les utilisateurs.trices pourront:

-   Utiliser Jupyter lab en local sur Anaconda ou dans les nuages sur
    MyBinder ou Azure notebooks
-   Copier/Coller les commandes dans l’interface de leur choix

Lectures complémentaires
========================

Écologie mathématique
---------------------

-   [How to be a quantitative ecologist](). Jason Mathipoulos vous prend
    par la main pour découvrir les notions de mathématiques
    fondamentales en écologie, appliquées avec le langage R.  
-   [Numerical
    ecology](https://www.elsevier.com/books/numerical-ecology/legendre/978-0-444-53868-0).
    L’ouvrage hautement détaillé des frères Legendre est non seulement
    fondamental, mais aussi fondateur d’une science qui évolue encore
    aujourd’hui: l’analyse des données écologiques.
-   [A practical guide to ecological
    modelling](http://www.springer.com/us/book/9781402086236). Soetaert
    et Herman portent une attention particulière à la présentation des
    principes de modélisation dans un langage accessible - ce qui est
    rarement le cas dans le domaine de la modélisation. Les modèles
    présentés concernent principalement les bilans de masse, en terme de
    systèmes de réactions chimiques et de relations biologiques.
-   [Modélisation mathématique en
    écologie](http://www.documentation.ird.fr/hor/fdi:010050350). Rare
    livre en modélisation écologique publié en français, la première
    partie s’attarde aux concepts mathématiques, alors que la deuxième
    planche à les appliquer. Si le haut niveau d’abstraction de la
    première partie vous rebute, n’hésitez pas débuter par la seconde
    partie et de vous référer à la première au besoin.
-   [A new ecology: systems
    perspective](https://www.elsevier.com/books/a-new-ecology/jorgensen/978-0-444-53160-5).
    Principalement grâce au soleil, la Terre forme un ensemble de
    gradients d’énergie qui se déclinent en des systèmes d’une étonnante
    complexité. C’est ainsi que le regreté Sven Erik Jørgensen
    (1934-2016) et ses collaborateurs décrivent les écosystèmes dans cet
    ouvrage qui fait suite aux travaux fondateurs de Howard Thomas Odum.

![](images/01_sven-jorgensen.png)

[Sven Erik
Jørgensen](http://scitechconnect.elsevier.com/in-memoriam-of-dr-sven-erik-jorgensen/)

-   Ecological engineering. Principle and Practice.
-   Ecological processes handbook.
-   Modeling complex ecological dynamics

Programmation
-------------

-   [R for data science](http://r4ds.had.co.nz/). L’analyse de données
    est une branche importante de l’écologie mathématique. Ce manuel
    traite des matrices et la manipulation de données chapitre 3), de la
    visualisation (chapitre 4) ainsi que de l’apprentissage automatique
    (chapitre 11). *R for data science* repasse ces sujets plus en
    profondeur. En particulier, l’ouvrage de [Garrett
    Grolemund](https://twitter.com/StatGarrett) et [Hadley
    Wickham](https://twitter.com/hadleywickham) offre une introduction
    au module graphique `ggplot2`.
-   [Numerical ecology with
    R](http://www.springer.com/la/book/9781441979759). Daniel Borcard
    enseigne l’écologie numérique à l’Université de Montréal. Son cours
    est condensé dans ce livre recettes voué à l’application des
    principes lourdement décrits dans [Numerical
    ecology](https://www.elsevier.com/books/numerical-ecology/legendre/978-0-444-53868-0).

Divers
------

-   [The truthful
    art](http://www.thefunctionalart.com/p/the-truthful-art-book.html).
    Dans cet ouvrage, Alberto Cairo s’intéresse à l’utilisation des
    données et de leurs présentation pour fournir une information
    adéquate à différents publics.

Besoin d’aide?
==============

Les ouvrages de référence reconnus vous offrent des bases solides sur
lesquelles vous pouvez vous appuyer dans vos travaux. Mais au-delà des
principes, au jour le jour, vous vous butterez immanquablement à toutes
sortes de petits problèmes. Quel module utiliser pour cette tâche
précise? Que veut dire ce message d’erreur? Comment interpréter ce
résultat? Pour tous les petits accrocs du quotidien en calcul
scientifique, internet offre de nombreuses ressources qui sont très
hétérogènes en qualité. Vous aprendrez à reconnaître les ressources
fiables à celles qui sont douteuses. Les plateformes basées sur Stack
Exchange, comme [Stack Overflow](https://stackoverflow.com) et [Cross
Validated](https://stats.stackexchange.com), m’ont souvent été d’une
aide précieuse. Vous aurez avantage à vous construire une petite banque
d’information ([Turtl](https://framanotes.org), Evernote, Google keep)
en collectant des liens, en prenant en notes certaines recettes et en
suivant des sites d’intérêt avec des flux RSS.

À propos de l’auteur
====================

Je m’appelle Serge-Étienne Parent. Je suis ingénieur écologue et
professeur adjoint au Département des sols et de génie agroalimentaire
de l’Université Laval, Québec, Canada. Je crois que la science est le
meilleur moyen d’appréhender le monde pour prendre des décisions
avisées, particulièrement en écologie, une science maltraitée de toute
part.

Un cours complémentaire à d’autres cours
========================================

Ce cours a été développé pour ouvrir des perspectives mathématiques en
écologie et en agronomie à la FSAA de l’Université Laval. Il est
complémentaire à certains cours offerts dans d’autres institutions
académiques au Québec, dont ceux-ci.

-   [BIO2041. Biostatistiques
    1](https://admission.umontreal.ca/cours-et-horaires/cours/bio-2041/),
    Université de Montréal
-   [BIO2042. Biostatistiques
    2](https://admission.umontreal.ca/cours-et-horaires/cours/BIO-2042/),
    Université de Montréal
-   [BIO109. Introduction à la programmation
    scientifique](https://github.com/EcoNumUdS/BIO109), Université de
    Sherbrooke
-   [BIO500. Méthodes en écologie
    computationnelle](https://github.com/EcoNumUdS/BIO500), Université
    de Sherbrooke.

Contribuer au manuel
====================

Je suis ouvert aux commentaires et suggestions. Pour contribuer
directement, dirigez-vous sur le dépôt du manuel sur [GitHub](), puis
ouvrez une Issue pour en discuter. Créez une nouvelle branche (*fork*),
effectuez les modifications, puis lancer une requête de fusion (*pull
resquest*).
