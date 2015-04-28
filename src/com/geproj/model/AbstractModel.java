package com.geproj.model;

import com.geproj.observer.Observable;

public abstract class AbstractModel implements Observable {
	int identifiant;
	
	//Effacer
	public abstract void reset();
	
	//Recupérer dans la BD
	public abstract void get();
	
	//Mettre à jour
	public abstract void update();
	
	//Enregistrer dans la BD
	//public abstract void commit();
	
	//Obtenir l'identifiant :
	public int getId(){
		return identifiant;
	}
}
