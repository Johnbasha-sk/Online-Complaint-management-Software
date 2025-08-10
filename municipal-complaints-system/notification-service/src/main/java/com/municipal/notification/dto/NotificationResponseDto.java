package com.municipal.notification.dto;

import com.municipal.notification.Notification;
import com.municipal.notification.entity.DeliveryStatus;
import com.municipal.notification.entity.NotificationChannel;
import com.municipal.notification.entity.NotificationType;
import java.time.LocalDateTime;

public class NotificationResponseDto {
    
    private Long id;
    private Long userId;
    private Long complaintId;
    private NotificationType type;
    private NotificationChannel channel;
    private String message;
    private String recipientEmail;
    private String recipientPhone;
    private DeliveryStatus deliveryStatus;
    private LocalDateTime sentAt;
    private LocalDateTime createdAt;
    private String errorMessage;
    
    public NotificationResponseDto() {
    }
    
    public NotificationResponseDto(Notification notification) {
        this.id = notification.getId();
        this.userId = notification.getUserId();
        this.complaintId = notification.getComplaintId();
        this.type = notification.getType();
        this.channel = notification.getChannel();
        this.message = notification.getMessage();
        this.recipientEmail = notification.getRecipientEmail();
        this.recipientPhone = notification.getRecipientPhone();
        this.deliveryStatus = notification.getDeliveryStatus();
        this.sentAt = notification.getSentAt();
        this.createdAt = notification.getCreatedAt();
        this.errorMessage = notification.getErrorMessage();
    }
    
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
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
    
    public DeliveryStatus getDeliveryStatus() {
        return deliveryStatus;
    }
    
    public void setDeliveryStatus(DeliveryStatus deliveryStatus) {
        this.deliveryStatus = deliveryStatus;
    }
    
    public LocalDateTime getSentAt() {
        return sentAt;
    }
    
    public void setSentAt(LocalDateTime sentAt) {
        this.sentAt = sentAt;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public String getErrorMessage() {
        return errorMessage;
    }
    
    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
    
    @Override
    public String toString() {
        return "NotificationResponseDto{" +
                "id=" + id +
                ", userId=" + userId +
                ", complaintId=" + complaintId +
                ", type=" + type +
                ", channel=" + channel +
                ", message='" + message + '\'' +
                ", recipientEmail='" + recipientEmail + '\'' +
                ", recipientPhone='" + recipientPhone + '\'' +
                ", deliveryStatus=" + deliveryStatus +
                ", sentAt=" + sentAt +
                ", createdAt=" + createdAt +
                ", errorMessage='" + errorMessage + '\'' +
                '}';
    }
}