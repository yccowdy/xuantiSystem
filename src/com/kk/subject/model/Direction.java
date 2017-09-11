package com.kk.subject.model;

public class Direction {

	private int id;
	private String direction;
	
	public Direction(){
		
	}
	public Direction(int id,String direction){
		this.setDirection(direction);
		this.setId(id);
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDirection() {
		return direction;
	}
	public void setDirection(String direction) {
		this.direction = direction;
	}
}
