package com.eds.model;

public class Admin {
    private int id;
    private String username;
    private String password;

    // ── Constructors ──
    public Admin() {}
    public Admin(int id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }

    // ── Getters ──
    public int getId(){
    	return id; 
    }
    public String getUsername(){ 
    	return username; 
    }
    public String getPassword(){ 
    	return password; 
    }

    // ── Setters ──
    public void setId(int id){ 
    	this.id = id; 
    }
    public void setUsername(String u){ 
    	this.username = u; 
    }
    public void setPassword(String p){
    	this.password = p; 
    }
}