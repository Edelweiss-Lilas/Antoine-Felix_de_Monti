<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <xsl:output method="html"/>
    
    <!-- ========================================== -->
    <!--      Génération de la page d'accueil -->
    <!-- ========================================== -->
    
    <!-- Variables et paramètres -->
    <xsl:variable name="header">
        <head>
            <meta charset="utf-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <link rel="preconnect" href="https://fonts.googleapis.com"/>
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous"/>
            <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100..900;1,100..900&amp;display=swap" rel="stylesheet"/>
            <link href="https://fonts.googleapis.com/css2?family=Playwrite+IE:wght@100..400&amp;display=swap" rel="stylesheet"/>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"/>
            <title>Les correspondances du Marquis de Monti, ambassadeur de France en Pologne</title>
            <style>
                #navbar > ul > li {
                display: inline-block;
                list-style: none;
                }
                .introduction-biographique {
                font-family:'Roboto', sans-serif;   
                background-color: #fdfdfd; /* Un fond très légèrement crème */
                border-bottom: 1px solid #ddd;
                margin-bottom: 30px;
                }                
                .introduction-biographique h2 {
                color: #8b4513; 
                text-align: center;
                }
                .banniere-historique {
                width: 100%;           
                height: 250px;         
                object-fit: cover;    
                object-position: center 60%; 
                border-bottom: 2px solid #b58d59; 
                }
                .fiche-marquis {
                display: grid;
                grid-template-columns: 1fr 1.5fr; /* 1 part pour l'image, 1.5 pour le texte */
                gap: 30px;                       
                max-width: 1000px;
                margin: 0 auto;
                /* Largeur importante pour la page */
                background: #fdfdfd;
                border: 1px solid #b58d59;
                padding: 20px;
                align-items: center;              
                }                
                /* Style pour la liste des infos */
                .fiche-info {
                list-style: none;
                padding: 0;
                text-align: left;                 
                }                
                .fiche-info li {
                margin-bottom: 10px;
                border-bottom: 1px dotted #ccc;  /* Petit trait de séparation entre les lignes */
                }
                /* Conteneur principal sous la bannière */
                .main-content {
                display: grid;
                grid-template-columns: 1fr 1fr; /* Deux colonnes égales */
                gap: 30px;
                max-width: 1200px;
                margin: 20px auto;
                }                
                /* Zone de transcription (style papier ancien) */
                .transcription-area {
                background-color: #fffaf0;
                padding: 40px;
                box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
                font-family: "EB Garamond", serif; 
                line-height: 1.8;
                }                
                /* Zone visionneuse (fixe au défilement) */
                .viewer-area {
                position: sticky;
                top: 20px;
                height: 700px;
                }
                .dateline {
                text-align: right;
                font-style: italic;
                margin-bottom: 2em;
                }
                .transcription-area p {
                text-indent: 2em;
                margin-bottom: 1em;
                text-align: justify;
                }                
                .folio-marker {
                color: #888;
                font-size: 0.9em;
                font-family: sans-serif;
                margin: 1em 0;
                display: block;
                }
                /* Styles pour les index */
                .index-container { max-width: 1000px; margin: 0 auto; padding: 20px; }
                .alphabet-nav { 
                text-align: center; 
                padding: 15px; 
                position: sticky; 
                top: 0; 
                background: #fff; 
                border-bottom: 2px solid #b58d59; 
                z-index: 10;
                margin-bottom: 20px;
                }
                .alphabet-nav a { 
                text-decoration: none; 
                font-weight: bold; 
                color: #8b4513; 
                margin: 0 8px; 
                font-size: 1.2em;
                }
                .index-letter { 
                font-family: 'Playwrite IE', cursive; 
                color: #b58d59; 
                border-bottom: 1px solid #eee; 
                padding-top: 30px;
                }
                .index-list { list-style: none; padding: 0; }
                .index-list li { 
                display: flex; 
                justify-content: space-between; 
                align-items: center;
                padding: 10px; 
                border-bottom: 1px dotted #ccc; 
                }
                .btn-lettre {
                text-decoration: none;
                color: #582900;
                background: #fdfdfd;
                border: 1px solid #ddd;
                padding: 3px 10px;
                border-radius: 5px;
                font-size: 0.9em;
                }
                .btn-lettre:hover { background: #b58d59; color: #fff; }
            </style>
        </head>
    </xsl:variable>
    
    <!-- Variable content le Footer -->
    <xsl:variable name="footer">
        <footer style="margin-top: 2em; border-top: 1px solid #ccc; padding-top: 1em; text-align: center;">
            <hr/>            
            <p>Ce site web a été réalisé dans le cadre d'un devoir XSLT du Master TNAH de l'École nationale des chartes</p>
            <p> © Fanny Suszko, 2026</p>
            <div style="margin-top: 2em; border-top: 2px; padding-top: 2em; text-align:right">
                <img src="image/logo-chartes-psl-coul.png" width="400" title="logo de l'ENC" alt="Logo de l'Ecole des Chartes"/>
            </div>
        </footer>
    </xsl:variable>
    
    <!-- Création d'un paramètre permettant de faire un lien entre les différentes pages html -->
    <xsl:template name="faireunlien">
        <xsl:param name="url"/>        
        <!-- On utilise l'accolade pour injecter le paramètre dans le href -->
        <a href="{$url}">
            <!-- Attention, n'oubliez pas de mettre du texte cliquable, sinon le lien sera invisible ! -->
            <xsl:text>Cliquez ici</xsl:text>
        </a>
    </xsl:template>
    
    <!-- Variable contenant la Navbar -->
    <xsl:variable name="navbar">
        <div style="text-align: center; font-family: Playwrite IE, cursive" id="navbar">
            <ul>
                <li><a href="accueil.html">Accueil</a> - </li>
                <li><a href="lettre_1.html">Lettre 1</a> - </li>
                <li><a href="lettre_2.html">Lettre 2</a> - </li>
                <li><a href="lettre_3.html">Lettre 3 </a> - </li>
                <li><a href="lettre_4.html">Lettre 4</a> - </li>
                <li><a href="index_personnages.html">Index personnages</a> - </li>
                <li><a href="index_lieux.html">Index lieux</a> - </li>
            </ul>
        </div>
    </xsl:variable>
    
    
    <!-- ========================================== -->
    <!-- Configuration de la pagination des pages HTML -->
    <!-- ========================================== -->
    
    
    <!-- Déclaration des règles afin de naviguer entre les différentes pages -->
    <xsl:template name="pagination">
        <!-- Ce paramètre ne servira que pour les index -->
        <xsl:param name="context"/>
        
        <div class="pagination" style="margin-top: 2em; border-top: 1px solid #ccc; padding-top: 1em; text-align: center;">
            
            <xsl:choose>
                <!-- CAS N°1 : SI ON EST SUR L'INDEX DES PERSONNAGES -->
                <xsl:when test="$context = 'index_personnages'">
                    <a href="lettre_{//div[@type='letter'][last()]/@n}.html">⬅️ Dernière lettre</a>
                    <xsl:text> | </xsl:text>
                    <a href="index_lieux.html">Index des lieux ➡️</a>
                </xsl:when>
                
                <!-- CAS N°2 : SI ON EST SUR L'INDEX DES LIEUX -->
                <xsl:when test="$context = 'index_lieux'">
                    <a href="index_personnages.html">⬅️ Index des personnages</a>
                    <xsl:text> | </xsl:text>
                    <a href="accueil.html">Retour à l'accueil ➡️</a>
                </xsl:when>
                
                <!-- CAS N°3 : PAR DÉFAUT, ON EST DANS LES LETTRES -->
                <xsl:otherwise>
                    
                    <xsl:choose>
                        <!-- S'il y a une lettre avant, on y va, sinon accueil -->
                        <xsl:when test="preceding-sibling::div[@type='letter']">
                            <a href="lettre_{preceding-sibling::div[@type='letter'][1]/@n}.html">⬅️ Lettre précédente</a>
                        </xsl:when>
                        <xsl:otherwise>
                            <a href="accueil.html">⬅️ Retour à l'accueil</a>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <xsl:text> | </xsl:text>
                    
                    <xsl:choose>
                        <!-- S'il y a une lettre après, on y va, sinon 1er index -->
                        <xsl:when test="following-sibling::div[@type='letter']">
                            <a href="lettre_{following-sibling::div[@type='letter'][1]/@n}.html">Lettre suivante ➡️</a>
                        </xsl:when>                
                        <xsl:otherwise>
                            <a href="index_personnages.html">Index des personnages ➡️</a>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <!-- ========================================== -->
    <!--    Création des pages pour les lettres -->
    <!-- ========================================== -->
    
    
    <xsl:template match="/">        
        <!-- On crée la boucle sur chaque lettre du document source -->
        <xsl:for-each select="//div[@type='letter']">
            <!-- pour chaque lettre pour ne pas avoir à le faire pour chaque lettre -->
            <xsl:result-document href="lettre_{@n}.html" method="html" indent="yes">
                <html lang="fr">
                    <xsl:copy-of select="$header"/> 
                    <body>
                        <!-- Bannière décorative commune à toutes les pages HTML -->
                        <div class="banniere">
                            <img src="image/manuscrit.jpeg" class="banniere-historique" alt="Bannière" />
                        </div>
                        <!-- Header de la lettre -->
                        <div class="metadata-header" style="margin-bottom: 3em; background-color: #f9f9f9; padding: 15px; border-radius: 5px;gap: 10px; text-align:center">
                        <div style="text-align:center; font-family: 'Playwrite IE', cursive;">
                            <h1><xsl:value-of select="head"/></h1>                            
                        </div>
                            <!-- Insertion du menu -->
                            <xsl:copy-of select="$navbar"/>
                            <!-- Mise en page en colonnes avec la transcription à gauche et le fac-similés à droite -->
                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px; max-width: 1400px; margin: 20px auto;">                
                                <!-- Concerne la partie de la transcription avec les règles s'appliquant au corps du texte -->
                                <div class="transcription-area" style="padding: 20px; background: #fffaf0; border: 1px solid #ddd; text-align: justify;">
                                    <xsl:apply-templates select="p | salute | postscript"/>
                                </div>                               
                                <!-- Concerne la partie des fac-similés pour visualiser les images qui sont fixes lors du défilement avec le sticky -->
                                <div style="position: sticky; top: 10px; height: 85vh; overflow-y: auto; background: #eee; padding: 10px; border: 1px solid #b58d59;">
                                    <h2 style="font-family: sans-serif; color: #8b4513;">Fac-similés</h2>
                                    <!-- Création d'une boucle sur chaque saut de page <pb> afin d'afficher l'image correspondanteâ -->
                                    <xsl:for-each select="descendant::pb">
                                        <div id="img-{@n}" style="margin-bottom: 30px; text-align: center;">
                                            <p style="font-family: sans-serif; font-weight: bold;">Folio <xsl:value-of select="@n"/></p>
                                            <img src="images_lettres/folio_{@n}.jpg" 
                                                style="width: 100%; box-shadow: 0 4px 8px rgba(0,0,0,0.3); border-radius: 3px;" 
                                                alt="Folio {@n}"/>
                                        </div>
                                    </xsl:for-each>
                                </div>
                            </div>
                        </div>
                        
                        <xsl:call-template name="pagination"/>
                        <xsl:copy-of select="$footer"/>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
            
        <!-- ========================================== -->
        <!--    Création de la page d'accueil -->
        <!-- ========================================== -->

        <xsl:result-document href="accueil.html" method="html" indent="yes">            
            <html lang="fr">
                <!-- Affichage du header -->
                <xsl:copy-of select="$header"/>               
                <body>
                    <div class="banniere">
                        <img src="image/manuscrit.jpeg" class="banniere-historique" alt="Bannière de la correspondance" />
                    </div>
                        <h1 style="text-align:center; font-family: Playwrite IE, cursive">Les correspondances du Marquis de Monti, ambassadeur de France en Pologne</h1>
                    <!-- Affichage de la navbar -->
                    <xsl:copy-of select="$navbar"/>
                    <!-- Paragraphe de présentation du marquis de Monti; afin de mieux comprendre qui il est et le rôle qu'il a joué -->
                    <section class="introduction-biographique">
                        <h2 style="text-align:center; font-family: Playwrite IE, cursive">Notice biographique</h2>
                        <p style="text-align: justify; font-family: Playwrite IE, cursive; ">Antoine-Félix, marquis de Monti, lieutenant général des armées du roi de France, chevalier des ordres de sa majesté, et commandant du régiment Royal-Italien, est né en Italie à Boulogne. C'est le frère de M. de Monti, 
                        secrétaire de la congrégation de la Propagande, fort estimé à la cour de Rome. Le marquis de Monti étant entré au service de France, s'y avança par son mérite, et fut fait brigadier. Le cardinal de Fleury le connaissait, qui le regardait comme un homme 
                        d'esprit, faisant beaucoup de cas de ses talents, le proposa au roi Louis XV pour qu'il reprenne à l'ambassade de Pologne à la suite de l'abbé de Livry. Le marquis de Monti fut envoyé en Pologne pour y favoriser l'élection du roi Stanislas Leszczynski.
                        Il participa à la Guerre de Succession de Pologne. Quand Dantzig, dernier bastion polonais, est tombé, le maréquis de Monti fut fait prisonnier par le maréchal de Munich. Il resta enfermé pendant dix-huit mois, les ambassadeurs français et Louis XV ont eu bien
                        du mal à le faire libérer. A son retour en France, il obtint la charge de lieutenant-général; et le premier janvier 1737, il fut fait chevalier de l'ordre du Saint-Esprit. Saint-Simon disait que l'on souhaite lui proposer l'ambassade de Vienne, mais Monti la refusa et 
                        mourut le 13 mars 1738 à Paris.</p>
                    </section>
                    <!-- Photo du marquis de Monti et de quelques informations biographiques -->
                    <div class="fiche-marquis">
                    <div class="portrait">
                        <a href="image/monti.jpg">
                            <img src="image/monti.jpg" width="400" title="Marquis de Monti" alt="Antoine-Félix de Monti(1681-1738)"/>
                        </a>
                    </div>
                        <div style="font-family: Playwrite IE, cursive">
                        <div class="details">
                            <h3>Antoine-Félix de Monti(1684-1738)</h3>
                          <ul class="fiche-info">                           
                           <li><strong>Naissance :</strong> 29 décembre 1684 à Bologne</li>
                           <li><strong>Décès :</strong> 13 mars 1738 à Paris</li>
                           <li><strong>Fratrie :</strong> Philippe-Marie de Monti (1675-1754)<br/></li>
                           <li><strong>Fonction :</strong> ambassadeur de France en Pologne (1729-1736) <br/>
                                       Aide de camp de Louis-Joseph de Vendôme à partir de 1703</li>
                          </ul>
                        </div>
                        </div>
                    </div>  
                    <!-- Informations extraites du teiHeader -->
                    <div style="display: flex; flex-direction: column; color: #582900; width: 60%; margin: 0 auto; box-shadow: 6px 6px 25px; border-radius: 10px; margin-top: 4em; border-top: 4em; border-left: 4em; border-right: 4em; border-bottom: 4em; font-family: Yantramanav; font-size: 1em; font-weight: 300; font-style: normal; text-align: center;">
                        <h2 style="font-family: Playwrite IE, cursive">Informations sur le manuscrit </h2>
                    <xsl:for-each select="//teiHeader"> 
                        <div style="font-family: Playwrite IE, cursive">
                        <ul>
                            <li>
                            <strong>Institution de conservation :</strong> 
                                <!-- Remplacement des xsl:copy par des xsl:value-of -->
                                <xsl:value-of select="fileDesc/sourceDesc/msDesc/msIdentifier/repository"/>, 
                                <xsl:value-of select="fileDesc/sourceDesc/msDesc/msIdentifier/settlement"/>
                            </li>
                            </ul>
                            <ul>
                                <li>
                                <strong>Nom du document :</strong> 
                                <xsl:value-of select="fileDesc/sourceDesc/msDesc/msIdentifier/msName"/>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                <strong>Cotes :</strong> 
                                <!-- Boucle pour récupérer toutes les cotes (idno) -->
                                <xsl:for-each select="fileDesc/sourceDesc/msDesc/msIdentifier/idno">
                                    <xsl:value-of select="."/>
                                    <!-- Condition pour ajouter une virgule entre les cotes, sauf pour la dernière -->
                                    <xsl:if test="position() != last()">, </xsl:if>
                                </xsl:for-each>
                                </li>
                            </ul>
                        
                        <h3>Informations de publication numérique</h3>                 
                            <ul>
                                <li><strong> Auteur :</strong><xsl:text>Fanny Suszko a réalisé ce travail d'encodage sur un petit échantillon de lettres issues de la correspondance du marquis de Monti, Antoine-Félix de Monti, ambassadeur de France en Pologne</xsl:text></li>
                                <li><strong>Éditeur :</strong><xsl:value-of select="fileDesc/publicationStmt/publisher"/> (<xsl:value-of select="fileDesc/publicationStmt/date"/>)</li>
                                <li><strong>Droits :</strong><xsl:value-of select="fileDesc/publicationStmt/availability/licence"/></li>
                            </ul>                           
                            
                        <h3>Historique des révisions du fichier XML</h3>                     
                            <!-- Boucle pour récupérer les changements effectués -->
                            <ul>
                            <xsl:for-each select="revisionDesc/change">
                                <li><em><xsl:value-of select="@when"/></em> : <xsl:value-of select="."/></li>
                            </xsl:for-each>
                            </ul>
                        </div>
                    </xsl:for-each>
                    <!-- AFFICHAGE DES TITRES DES LETTRES -->
                    <h1 style="font-family: Playwrite IE, cursive;">Liste des lettres</h1>                    
                        <xsl:for-each select="//div[@type='letter']">
                            <ul>
                                <li>
                                <!-- L'accolade va générer lettre_1.html, lettre_2.html, etc. -->
                                <a href="lettre_{@n}.html">
                                    <xsl:value-of select="./head"/>
                                </a>
                                </li>
                            </ul>
                        </xsl:for-each>                         
                    </div>                                     
                    <xsl:copy-of select="$footer"/>
               </body>
            </html>
        </xsl:result-document>
        <!-- Création de la page d'index des personnages -->
        <xsl:result-document href="index_personnages.html" method="html" indent="yes">
            <html lang="fr">
                <xsl:copy-of select="$header"/>                
                <body>
                    <div class="banniere">
                        <img src="image/manuscrit.jpeg" class="banniere-historique" alt="Bannière de la correspondance" />
                    </div>
                    <h1 style="text-align: center; font-family: Playwrite IE, cursive">Index par noms</h1>
                    <xsl:copy-of select="$navbar"/>                    
                    <!-- Début de la nouvelle structure d'index -->
                    <div class="index-container">
                        <!-- Barre de navigation alphabétique -->
                        <nav class="alphabet-nav">                            
                            <xsl:for-each-group select="//persName[@ref]" group-by="upper-case(substring(substring-after(@ref, '#'), 1, 1))">
                                <xsl:sort select="current-grouping-key()"/>
                                <a href="#letter-{current-grouping-key()}"><xsl:value-of select="current-grouping-key()"/></a>
                                <xsl:text> </xsl:text>
                            </xsl:for-each-group>
                        </nav>
                        <!-- On crée une boucle permettant de regrouper par la première lettre du personnage afin de créer les sections alphabéthiques -->
                        <xsl:for-each-group select="//persName[@ref]" group-by="upper-case(substring(substring-after(@ref, '#'), 1, 1))">
                            <!-- Trier les groupes par lettre alphabétique -->
                            <xsl:sort select="current-grouping-key()"/>
                            
                            <div class="index-section" id="letter-{current-grouping-key()}">
                                <h2 class="index-letter"><xsl:value-of select="current-grouping-key()"/></h2>
                                <ul class="index-list">
                                    <!-- On regroupe les occurences par lieu spécifique en utilisant l'attribut @ref-->
                                    <xsl:for-each-group select="current-group()" group-by="@ref">
                                        <xsl:sort select="substring-after(current-grouping-key(), '#')"/>
                                        <li>
                                            <span class="entry-name">
                                                <strong>
                                                    <!-- Affichage du nom propre nettoyé (sans _ et sans #) -->
                                                    <xsl:value-of select="translate(substring-after(current-grouping-key(),'#'), '_', ' ')"/>
                                                </strong>
                                            </span>
                                            <span class="entry-links">
                                                <!-- On regroupe par numéro de lettre les personnages pour éviter les doublons menant à une même lettre -->
                                                <xsl:for-each-group select="current-group()" group-by="ancestor::div[@type='letter']/@n">
                                                    <a href="lettre_{current-grouping-key()}.html" class="btn-lettre">
                                                        <xsl:text>Lettre </xsl:text><xsl:value-of select="current-grouping-key()"/>
                                                    </a>
                                                    <!-- On ajoute une vigurle de séparation -->
                                                    <xsl:if test="position() != last()">, </xsl:if>
                                                </xsl:for-each-group>
                                            </span>
                                        </li>
                                    </xsl:for-each-group>
                                </ul>
                            </div>
                        </xsl:for-each-group>
                    </div>
                    <xsl:call-template name="pagination">
                        <xsl:with-param name="context" select="'index_personnages'"/>
                    </xsl:call-template>       
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- On ouvre le document pour l'index des lieux -->
        <xsl:result-document href="index_lieux.html" method="html" indent="yes">
                        <html lang="fr">
                            <xsl:copy-of select="$header"/>                            
                            <body> 
                                <div class="banniere">
                                    <img src="image/manuscrit.jpeg" class="banniere-historique" alt="Bannière de la correspondance" />
                                </div>
                                <h1 style="text-align:center; font-family: Playwrite IE, cursive">Index des Lieux</h1>
                                <xsl:copy-of select="$navbar"/>                                                            
                                    <!-- 2. BOUCLE PRINCIPALE : on cible les lieux au lieu des personnages -->
                                    <div class="index-container">
                                        <nav class="alphabet-nav">
                                            <xsl:for-each-group select="//placeName[@ref]" group-by="upper-case(substring(substring-after(@ref, '#'), 1, 1))">
                                                <xsl:sort select="current-grouping-key()"/>
                                                <a href="#letter-{current-grouping-key()}"><xsl:value-of select="current-grouping-key()"/></a>
                                                <xsl:text> </xsl:text>
                                            </xsl:for-each-group>
                                        </nav>
                                        <!-- On crée une boucle permettant de regrouper par la première lettre du lieu afin de créer les sections alphabéthiques -->
                                        <xsl:for-each-group select="//placeName[@ref]" group-by="upper-case(substring(substring-after(@ref, '#'), 1, 1))">
                                            <!-- Trier les groupes par lettre alphabétique -->
                                            <xsl:sort select="current-grouping-key()"/>
                                            <div class="index-section" id="letter-{current-grouping-key()}">
                                                <h2 class="index-letter"><xsl:value-of select="current-grouping-key()"/></h2>
                                                <ul class="index-list">
                                                    <!-- On regroupe les occurences par lieu spécifique en utilisant l'attribut @ref-->
                                                    <xsl:for-each-group select="current-group()" group-by="@ref">
                                                        <xsl:sort select="substring-after(current-grouping-key(), '#')"/>
                                                        <li>
                                                            <span class="entry-name">
                                                                <!-- On nettoie l'identifiant en enlevant le '#' et les '_' sont remplacés par des espaces -->
                                                                <strong><xsl:value-of select="translate(substring-after(current-grouping-key(), '#'), '_', ' ')"/></strong>
                                                            </span>
                                                            <span class="entry-links">
                                                                <!-- On regroupe par numéro de lettre les lieux pour éviter les doublons menant à une même lettre -->
                                                                <xsl:for-each-group select="current-group()" group-by="ancestor::div[@type='letter']/@n">
                                                                    <a href="lettre_{current-grouping-key()}.html" class="btn-lettre">
                                                                        <xsl:text>Lettre </xsl:text><xsl:value-of select="current-grouping-key()"/>
                                                                    </a>
                                                                    <!-- On ajoute une vigurle de séparation -->
                                                                    <xsl:if test="position() != last()">, </xsl:if>
                                                                </xsl:for-each-group>
                                                            </span>
                                                        </li>
                                                    </xsl:for-each-group>
                                                </ul>
                                            </div>
                                        </xsl:for-each-group>
                                    </div>
                                <xsl:call-template name="pagination">
                                    <xsl:with-param name="context" select="'index_lieux'"/>
                                </xsl:call-template>
                                <xsl:copy-of select="$footer"/>
                            </body>
                        </html>
                    </xsl:result-document>
    </xsl:template>
  
    <!-- Lien entre les lieux dans les textes et l'index -->
    <xsl:template match="placeName[@ref]">        
            <xsl:value-of select="placeName"/>
        <!-- Création du lien pointant vers la page index_lieux.html -->
        <a href="index_lieux.html#{substring-after(@ref, '#')}">
            <!-- On conserve le nom du lieu avec la lettre pour que celle-ci devienne le texte cliquable -->
            <xsl:value-of select="."/>
        </a>
    </xsl:template>
    
    <!-- Lien entre les personnages dans les textes et l'index -->
    <xsl:template match="persName[@ref]">     
            <!-- Création du lien pointant vers la page index_personnages.html -->
        <a href="index_personnages.html#{translate(substring-after(@ref, '#'), ' ', '_')}">
                <!-- On conserve le nom du personnage pour que celui-ci devienne le texte cliquable -->
                <xsl:value-of select="."/>
            </a>
    </xsl:template>
    
    <!-- Conservation des retours à la ligne traditionnelle du manuscrit -->
    <xsl:template match="lb"><br/>
    </xsl:template>
    <!-- Indication que l'on change de page dans le manuscrit originel -->
    <xsl:template match="pb">
        <span class="folio-marker" style="color: #8b4513; font-weight: bold; display: block; margin: 1.5em 0; border-top: 1px dashed #ccc;">
            <a href="#img-{@n}" style="color: inherit; text-decoration: none;">
                [Folio <xsl:value-of select="@n"/> - Cliquez pour voir l'image]
            </a>
        </span>
    </xsl:template>
    

</xsl:stylesheet>