package com.geproj.view;

import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;

import com.geproj.observer.Observer;

public class Principal extends JFrame implements Observer{
	private JPanel container = new JPanel();
	private JMenuBar menuBar = new JMenuBar();
	private JMenu fichier = new JMenu("Fichier");
		private JMenuItem fichierNouveauProjet = new JMenuItem("Nouveau Projet");
		private JMenuItem fichierAide = new JMenuItem("Aide");
		private JMenuItem fichierExit = new JMenuItem("Quitter");
	private JMenu projet = new JMenu("Projet");
		private JMenuItem projetNouveau = new JMenuItem("Ajouter un sous-projet");
	
	public static void main(String[] args){
		
	}
}
