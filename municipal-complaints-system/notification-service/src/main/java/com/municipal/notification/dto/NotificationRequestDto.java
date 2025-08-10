package com.municipal.notification.dto;

import com.municipal.notification.entity.NotificationChannel;
import com.municipal.notification.entity.NotificationType;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Email;

public class NotificationRequestDto {
    
    @NotNull(message = "User ID is required")
    private Long userId;
    
    private Long complaintId;
    
    @NotNull(message = "Notification type is required")
    private NotificationType type;
    
    @NotNull(message = "Notification channel is required")
    private NotificationChannel channel;
    
    @NotBlank(message = "Message is required")
    private String message;
    
    @Email(message = "Invalid email format")
    private String recipientEmail;
    
    private String recipientPhone;
    
    public NotificationRequestDto() {
    }
    
    public NotificationRequestDto(Long userId, Long complaintId, NotificationType type, 
                                NotificationChannel channel, String message, 
                                String recipientEmail, String recipientPhone) {
        this.userId = userId;
        this.complaintId = complaintId;
        this.type = type;
        this.channel = channel;
        this.message = message;
        this.recipientEmail = recipientEmail;
        this.recipientPhone = recipientPhone;
    }
    
    public Long getUserId() {
        return userId;
    }
    
    public void setUserId(Long userId) {
        this.userId = userId;
    }
    
    public Long getComplaintId() {
        return complaintId;
    }
    
    public void setComplaintId(Long complaintId) {
        this.complaintId = complaintId;
    }
    
    public NotificationType getType() {
        return type;
    }
    
    public void setType(NotificationType type) {
        this.type = type;
    }
    
    public NotificationChannel getChannel() {
        return channel;
    }
    
    public void setChannel(NotificationChannel channel) {
        this.channel = channel;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    public String getRecipientEmail() {
        return recipientEmail;
    }
    
    public void setRecipientEmail(String recipientEmail) {
        this.recipientEmail = recipientEmail;
    }
    
    public String getRecipientPhone() {
        return recipientPhone;
    }
    
    public void setRecipientPhone(String recipientPhone) {
        this.recipientPhone = recipientPhone;
    }
    
    @Override
    public String toString() {
        return "NotificationRequestDto{" +
                "userId=" + userId +
                ", complaintId=" + complaintId +
                ", type=" + type +
                ", channel=" + channel +
                ", message='" + message + '\'' +
                ", recipientEmail='" + recipientEmail + '\'' +
                ", recipientPhone='" + recipientPhone + '\'' +
                '}';
    }
}