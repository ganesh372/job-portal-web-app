package com.jobportal.dao;

import com.jobportal.model.Application;
import com.jobportal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {

    public boolean applyForJob(Application app) throws SQLException {
        String sql = "INSERT INTO applications (job_id, candidate_id, resume_path, cover_letter) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, app.getJobId());
            ps.setInt(2, app.getCandidateId());
            ps.setString(3, app.getResumePath());
            ps.setString(4, app.getCoverLetter());
            return ps.executeUpdate() > 0;
        }
    }

    public List<Application> getApplicationsByCandidate(int candidateId) throws SQLException {
        String sql = "SELECT a.*, j.title AS job_title, j.company FROM applications a " +
                     "JOIN jobs j ON a.job_id = j.id " +
                     "WHERE a.candidate_id = ? ORDER BY a.applied_at DESC";
        List<Application> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Application app = mapApplication(rs);
                    app.setJobTitle(rs.getString("job_title"));
                    app.setCompany(rs.getString("company"));
                    list.add(app);
                }
            }
        }
        return list;
    }

    public List<Application> getApplicationsByEmployer(int employerId) throws SQLException {
        String sql = "SELECT a.*, j.title AS job_title, j.company, u.name AS candidate_name, u.email AS candidate_email " +
                     "FROM applications a " +
                     "JOIN jobs j ON a.job_id = j.id " +
                     "JOIN users u ON a.candidate_id = u.id " +
                     "WHERE j.employer_id = ? ORDER BY a.applied_at DESC";
        List<Application> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, employerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Application app = mapApplication(rs);
                    app.setJobTitle(rs.getString("job_title"));
                    app.setCompany(rs.getString("company"));
                    app.setCandidateName(rs.getString("candidate_name"));
                    app.setCandidateEmail(rs.getString("candidate_email"));
                    list.add(app);
                }
            }
        }
        return list;
    }

    public boolean updateApplicationStatus(int applicationId, String status) throws SQLException {
        String sql = "UPDATE applications SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, applicationId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean hasApplied(int jobId, int candidateId) throws SQLException {
        String sql = "SELECT id FROM applications WHERE job_id = ? AND candidate_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.setInt(2, candidateId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    private Application mapApplication(ResultSet rs) throws SQLException {
        Application app = new Application();
        app.setId(rs.getInt("id"));
        app.setJobId(rs.getInt("job_id"));
        app.setCandidateId(rs.getInt("candidate_id"));
        app.setResumePath(rs.getString("resume_path"));
        app.setCoverLetter(rs.getString("cover_letter"));
        app.setStatus(rs.getString("status"));
        app.setAppliedAt(rs.getTimestamp("applied_at"));
        return app;
    }
}
