package com.geproj.controler;

import com.geproj.model.AbstractModel;

public abstract class AbstractControler {
	protected AbstractModel model;
	
	public AbstractControler (AbstractModel mod){
		this.model = mod;
	}
	
	abstract void control();
}
