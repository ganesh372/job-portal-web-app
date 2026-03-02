package com.jobportal.model;

import java.sql.Timestamp;

public class Job {
    private int id;
    private int employerId;
    private String title;
    private String company;
    private String location;
    private String description;
    private String requirements;
    private String salary;
    private Timestamp createdAt;

    public Job() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getEmployerId() { return employerId; }
    public void setEmployerId(int employerId) { this.employerId = employerId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getCompany() { return company; }
    public void setCompany(String company) { this.company = company; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getRequirements() { return requirements; }
    public void setRequirements(String requirements) { this.requirements = requirements; }

    public String getSalary() { return salary; }
    public void setSalary(String salary) { this.salary = salary; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
