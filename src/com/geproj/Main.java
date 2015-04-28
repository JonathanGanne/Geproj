package com.geproj;

import com.geproj.controler.AbstractControler;
import com.geproj.controler.ProjectControler;
import com.geproj.model.AbstractModel;
import com.geproj.model.Projet;
import com.geproj.view.Geproj;

public class Main {

	public static void main(String[] args) {
		AbstractModel model = new Projet();
		AbstractControler controler = new ProjectControler(model);
		Geproj fenetre = new Geproj(controler); 
		model.addObserver(fenetre);
	}

}
