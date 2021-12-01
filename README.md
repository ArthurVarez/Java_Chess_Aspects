# Programmation objet avancée : TP2 Question 2


## I Utilisation

### Eclipse

Nous avons essayés de réaliser le projet avec Eclipse, malheursuement il m'a été impssible de lancer un projet AspectJ avec Eclipse, il y avait systématiquement une erreur du logiciel.
De ce fait nous avons également réaliser un makefile pour lancer le projet.

### Makefile

Le Makfile possède 3 commandes:
- make: build le projet dans un dossier bin
- make run: éxécute le projet
- make clean: supprime le dossier bin

### Notes de conception

Afin de répondre à la problématique du TP, on a dû réaliser deux aspects afin de gérer le logging de chaque tour du jeu et pour gérer la validation de chaque coup du joueur.

#### LoggerAspect

Le **LoggerAspect** permet de gérer les logs de la partie de jeu. Pour ceci on a créé deux pointcuts. Le premier est simplement un pointcut sur la fontion **main** du programme, qui permet d'écrire quand le programme commence et quand est-ce qu'il se termine. Le second pointcut se greffe sur la fonction **movePiece**. de la class **Board**. Lors de l'appel de cette fonction, on se sert de notre aspect afin de récupérer les informations du mouvement qui est effectué avant de les ajouter aux logs. Notre aspect possède également un incrémenteur qui va permettre de compter les tours joués.

Les logs sont ajoutés dans le fichier **output.txt**.

#### ValidateMoveAspect

Le **ValidateMoveAspect** permet de vérifier que le mouvement d'une pièce du joueur est autorisé. Pour ce faire, on a créé un pointcut sur la fonction **makeMove** de **HumanPlayer**. Ce pointcut permet d'inhiber l'appel de la fonction **makeMove** et de vérifier si le mouvement est valide avant de la réaliser. Pour ceci, on utilise la classe **MoveValidator** qui possède des fonctions pemettant chacune de vérifier une règle des échecs à vérifier:
- **isValidSpot**: Vérifie que l'emplacement de départ choisie n'est pas une case vide
- **isPlayerPiece**: Vérifie que l'emplacement de départ choisie n'est pas une pièce ennemie.
- **isValidMovement**: Vérifie que le movement effectué est faisable par la pièce sélectionné
- **isInBoard**: Vérifie que la position d'arrivé de la pièce se situe sur le terrain de jeu
- **notComingOnAlly**: Vérifie que la position d'arrivé de la pièce n'est pas une pièce allié
- **notGoingThroughOtherPiece**: Vérifie qu'il n'y a pas de pièce se trouvant sur la trajectiore de la pièce selectionné

Si l'une de ces conditions n'est pas remplie, la fonction de notre apect renverra **false** en inhibant l'appel de la fonction **makeMove**, ce qui aura pour conséquence de redemander au joueur de sélectionner un mouvement à faire.
À l'inverse, si toutes ces conditions sont remplies, l'aspect fera appel à la fonction **makeMove** et le programme continuera.

### Modification apporté au programme

Nous avons apporté une modification mineure au programme. En effet, cette dernière ne change rien au fonctionnement du programme, nous avons simplement modifié la valeur de retour de la fonction **toString** de la pièce **Bishop** car cette dernière possède la même lettre que la pièce **Pawn**. Le **Bishop** est désormais représenté par un *p* ou un *P*.
