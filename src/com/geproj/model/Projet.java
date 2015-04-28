package com.geproj.model;

import com.geproj.observer.Observer;

public class Projet extends AbstractModel{
	private String name;
	private String objectif;
	private String resultat;
	
	public Projet(){
		name = "Nouveau projet";
		objectif = "";
		resultat = "";
	}
	
	
	//Accesseurs
	public String getName(){
		return name;
	}
	public String getObjectif(){
		return objectif;
	}
	public String getResultat(){
		return resultat;
	}
	
	
	// Mutateurs
	public void setName(String name){
		this.name = name;
	}
	
	public void setObjectif(String objectif){
		this.objectif = objectif;
	}


	@Override
	public void addObserver(Observer obs) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void removeObserver() {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void notifyObserver(String str) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void reset() {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void get() {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void update() {
		// TODO Auto-generated method stub
		
	}

	
}
