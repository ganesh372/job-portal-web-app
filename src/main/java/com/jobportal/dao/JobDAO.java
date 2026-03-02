package com.jobportal.dao;

import com.jobportal.model.Job;
import com.jobportal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    public boolean postJob(Job job) throws SQLException {
        String sql = "INSERT INTO jobs (employer_id, title, company, location, description, requirements, salary) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, job.getEmployerId());
            ps.setString(2, job.getTitle());
            ps.setString(3, job.getCompany());
            ps.setString(4, job.getLocation());
            ps.setString(5, job.getDescription());
            ps.setString(6, job.getRequirements());
            ps.setString(7, job.getSalary());
            return ps.executeUpdate() > 0;
        }
    }

    public List<Job> getAllJobs() throws SQLException {
        String sql = "SELECT * FROM jobs ORDER BY created_at DESC";
        List<Job> jobs = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                jobs.add(mapJob(rs));
            }
        }
        return jobs;
    }

    public List<Job> searchJobs(String keyword) throws SQLException {
        String sql = "SELECT * FROM jobs WHERE title LIKE ? ESCAPE '!' OR company LIKE ? ESCAPE '!' OR location LIKE ? ESCAPE '!' ORDER BY created_at DESC";
        List<Job> jobs = new ArrayList<>();
        // Escape LIKE special characters to prevent wildcard injection
        String escaped = keyword.replace("!", "!!").replace("%", "!%").replace("_", "!_");
        String pattern = "%" + escaped + "%";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ps.setString(3, pattern);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    jobs.add(mapJob(rs));
                }
            }
        }
        return jobs;
    }

    public List<Job> getJobsByEmployer(int employerId) throws SQLException {
        String sql = "SELECT * FROM jobs WHERE employer_id = ? ORDER BY created_at DESC";
        List<Job> jobs = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, employerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    jobs.add(mapJob(rs));
                }
            }
        }
        return jobs;
    }

    public Job getJobById(int id) throws SQLException {
        String sql = "SELECT * FROM jobs WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapJob(rs);
                }
            }
        }
        return null;
    }

    private Job mapJob(ResultSet rs) throws SQLException {
        Job job = new Job();
        job.setId(rs.getInt("id"));
        job.setEmployerId(rs.getInt("employer_id"));
        job.setTitle(rs.getString("title"));
        job.setCompany(rs.getString("company"));
        job.setLocation(rs.getString("location"));
        job.setDescription(rs.getString("description"));
        job.setRequirements(rs.getString("requirements"));
        job.setSalary(rs.getString("salary"));
        job.setCreatedAt(rs.getTimestamp("created_at"));
        return job;
    }
}
