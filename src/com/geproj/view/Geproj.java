package com.geproj.view;

import java.awt.Color;

import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;

import com.geproj.controler.AbstractControler;
import com.geproj.observer.Observer;

public class Geproj extends JFrame implements Observer{
	private JPanel pan = new JPanel();
	   
	private JMenuBar menuBar = new JMenuBar();
	private JMenu fichier = new JMenu("Fichier");
		private JMenuItem fichierNouveauProjet = new JMenuItem("Nouveau Projet");
		private JMenuItem fichierAide = new JMenuItem("Aide");
		private JMenuItem fichierExit = new JMenuItem("Quitter");
	private JMenu projet = new JMenu("Projet");
		private JMenuItem projetNouveau = new JMenuItem("Ajouter un sous-projet");
	   
	//L'instance de notre objet contrôleur
	private AbstractControler controler;
	
	public Geproj(AbstractControler controler){
		this.setSize(800,600);
		this.setTitle("Geproj");
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	    this.setLocationRelativeTo(null);
	    this.setResizable(true);
	    initComposant();                
	    this.controler = controler;                
	    this.setContentPane(pan);
	    this.setVisible(true);
	}
	
	private void initComposant(){
		//Font police = new Font("Arial", Font.BOLD, 20);
		
		this.fichier.add(fichierNouveauProjet);
		this.fichier.add(fichierAide);
		this.fichier.add(fichierExit);
		
		this.projet.add(projetNouveau);
		
		this.menuBar.add(fichier);
		this.menuBar.add(projet);
		
		this.setJMenuBar(menuBar);
		
		this.pan.setBackground(Color.ORANGE);
		this.setContentPane(pan);
	}
	@Override
	public void update(String str) {
		// TODO Auto-generated method stub
		
	}

}
