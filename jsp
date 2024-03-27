import pygame
import sys

pygame.init()

largeur, hauteur = 800, 800
cadrex , cadrey = 100, 100
cadrex1 , cadrey1 = 716, 716
lignes, colonnes = 14, 14
taille_cellule = (cadrex1 - cadrex) // colonnes

noir = (0, 0, 0)
blanc = (0, 49, 31)
gris = (200, 200, 200)
vert = (255,255,255)

ecran = pygame.display.set_mode((largeur, hauteur))
pygame.display.set_caption("Jeu de Sudoku")

plateau = [[0 for _ in range(colonnes)] for _ in range(lignes)]

joueur_actuel = 1

def dessiner_plateau():
    ecran.fill(blanc)
    for x in range(cadrex, cadrex1 , taille_cellule):
        pygame.draw.line(ecran, gris, (x, cadrey), (x, cadrey1-taille_cellule))
    for y in range(cadrey, cadrey1 , taille_cellule):
        pygame.draw.line(ecran, gris, (cadrex, y), (cadrex1-taille_cellule, y))

    for ligne in range(lignes):
        for colonne in range(colonnes):
            if plateau[ligne][colonne] != 0:
                couleur = noir if plateau[ligne][colonne] == 1 else vert

                x = cadrex + colonne * taille_cellule + taille_cellule // 9-3
                y = cadrey + ligne * taille_cellule + taille_cellule // 9-3

                pygame.draw.circle(ecran, couleur, (x, y), taille_cellule // 4)

def gerer_clic(x, y):
    global joueur_actuel
    colonne = (x - cadrex+20) // taille_cellule
    ligne = (y - cadrey+20) // taille_cellule

    if x>= 100 and y>=100 and x<=812 and y<=812:
        if plateau[int(ligne)][int(colonne)] == 0:
            plateau[int(ligne)][int(colonne)] = joueur_actuel
        if verifier_victoire(int(ligne), int(colonne)):
            print("Le joueur", joueur_actuel, "a gagné !")
            pygame.quit()
            sys.exit()
        joueur_actuel = 1 if joueur_actuel == 2 else 2
    else:
         return None



def verifier_victoire(ligne, colonne):

    alignement = 0
    for j in range(colonnes):
        if plateau[ligne][j] == joueur_actuel:
            alignement += 1
            if alignement == 5:
                return True
        else:
            alignement = 0
    alignement = 0
    for i in range(lignes):
        if plateau[i][colonne] == joueur_actuel:
            alignement += 1
            if alignement == 5:
                return True
        else:
            alignement = 0


    alignement = 0
    i, j = ligne, colonne
    while i < lignes and j < colonnes:
        if plateau[i][j] == joueur_actuel:
            alignement += 1
            if alignement == 5:
                return True
        else:
            alignement = 0
        i += 1
        j += 1

    i, j = ligne, colonne
    while i >= 0 and j >= 0:
        if plateau[i][j] == joueur_actuel:
            alignement += 1
            if alignement == 5:
                return True
        else:
            alignement = 0
        i -= 1
        j -= 1


    alignement = 0
    i, j = ligne, colonne
    while i >= 0 and j < colonnes:
        if plateau[i][j] == joueur_actuel:
            alignement += 1
            if alignement == 5:
                return True
        else:
            alignement = 0
        i -= 1
        j += 1

    i, j = ligne, colonne
    while i < lignes and j >= 0:
        if plateau[i][j] == joueur_actuel:
            alignement += 1
            if alignement == 5:
                return True
        else:
            alignement = 0
        i += 1
        j -= 1

    return False

en_cours = True
while en_cours:
    for evenement in pygame.event.get():
        if evenement.type == pygame.QUIT:
            en_cours = False
        elif evenement.type == pygame.MOUSEBUTTONDOWN:
            x, y = pygame.mouse.get_pos()
            gerer_clic(x, y)
            colonne = (x - cadrex) // taille_cellule
            ligne = (y - cadrey) // taille_cellule
            print("Colonne:", colonne)
            print("Ligne:", ligne)

    dessiner_plateau()
    pygame.display.flip()

pygame.quit()
