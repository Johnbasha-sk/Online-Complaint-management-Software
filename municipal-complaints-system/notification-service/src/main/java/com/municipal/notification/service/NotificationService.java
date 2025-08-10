package com.municipal.notification.service;

import com.municipal.notification.Notification;
import com.municipal.notification.dto.NotificationRequestDto;
import com.municipal.notification.dto.NotificationResponseDto;
import com.municipal.notification.entity.DeliveryStatus;
import com.municipal.notification.entity.NotificationChannel;
import com.municipal.notification.entity.NotificationType;
import com.municipal.notification.repository.NotificationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class NotificationService {
    
    private final NotificationRepository notificationRepository;
    private final JavaMailSender emailSender;
    
    @Value("${spring.mail.username}")
    private String fromEmail;
    
    @Value("${twilio.account.sid}")
    private String twilioAccountSid;
    
    @Value("${twilio.auth.token}")
    private String twilioAuthToken;
    
    @Value("${twilio.phone.number}")
    private String twilioPhoneNumber;
    
    @Autowired
    public NotificationService(NotificationRepository notificationRepository, 
                             JavaMailSender emailSender) {
        this.notificationRepository = notificationRepository;
        this.emailSender = emailSender;
    }
    
    public NotificationResponseDto sendNotification(NotificationRequestDto requestDto) {
        // Create notification record
        Notification notification = new Notification(
            requestDto.getUserId(),
            requestDto.getComplaintId(),
            requestDto.getType(),
            requestDto.getChannel(),
            requestDto.getMessage(),
            requestDto.getRecipientEmail(),
            requestDto.getRecipientPhone()
        );
        
        // Save notification record
        Notification savedNotification = notificationRepository.save(notification);
        
        try {
            // Send notification based on channel
            boolean sent = false;
            String errorMessage = null;
            
            switch (requestDto.getChannel()) {
                case EMAIL:
                    if (requestDto.getRecipientEmail() != null) {
                        sent = sendEmail(requestDto.getRecipientEmail(), 
                                       getEmailSubject(requestDto.getType()), 
                                       requestDto.getMessage());
                    }
                    break;
                    
                case SMS:
                    if (requestDto.getRecipientPhone() != null) {
                        sent = sendSMS(requestDto.getRecipientPhone(), requestDto.getMessage());
                    }
                    break;
                    
                case BOTH:
                    boolean emailSent = false;
                    boolean smsSent = false;
                    
                    if (requestDto.getRecipientEmail() != null) {
                        emailSent = sendEmail(requestDto.getRecipientEmail(), 
                                           getEmailSubject(requestDto.getType()), 
                                           requestDto.getMessage());
                    }
                    
                    if (requestDto.getRecipientPhone() != null) {
                        smsSent = sendSMS(requestDto.getRecipientPhone(), requestDto.getMessage());
                    }
                    
                    sent = emailSent || smsSent;
                    break;
            }
            
            // Update notification status
            if (sent) {
                savedNotification.setDeliveryStatus(DeliveryStatus.SENT);
                savedNotification.setSentAt(LocalDateTime.now());
            } else {
                savedNotification.setDeliveryStatus(DeliveryStatus.FAILED);
                savedNotification.setErrorMessage("Failed to send notification");
            }
            
            notificationRepository.save(savedNotification);
            
        } catch (Exception e) {
            savedNotification.setDeliveryStatus(DeliveryStatus.FAILED);
            savedNotification.setErrorMessage("Exception: " + e.getMessage());
            notificationRepository.save(savedNotification);
        }
        
        return new NotificationResponseDto(savedNotification);
    }
    
    private boolean sendEmail(String toEmail, String subject, String message) {
        try {
            SimpleMailMessage mailMessage = new SimpleMailMessage();
            mailMessage.setFrom(fromEmail);
            mailMessage.setTo(toEmail);
            mailMessage.setSubject(subject);
            mailMessage.setText(message);
            
            emailSender.send(mailMessage);
            return true;
        } catch (Exception e) {
            // Log error
            return false;
        }
    }
    
    private boolean sendSMS(String phoneNumber, String message) {
        try {
            // For now, we'll use a placeholder implementation
            // In production, you would integrate with Twilio or another SMS provider
            if (twilioAccountSid != null && twilioAuthToken != null) {
                // Twilio integration would go here
                // For MVP, we'll just return true to simulate success
                return true;
            } else {
                // Log that SMS is not configured
                return false;
            }
        } catch (Exception e) {
            // Log error
            return false;
        }
    }
    
    private String getEmailSubject(NotificationType type) {
        switch (type) {
            case COMPLAINT_CREATED:
                return "New Complaint Filed";
            case COMPLAINT_ASSIGNED:
                return "Complaint Assigned to Department";
            case COMPLAINT_STATUS_UPDATED:
                return "Complaint Status Updated";
            case COMMENT_ADDED:
                return "New Comment on Complaint";
            case COMPLAINT_RESOLVED:
                return "Complaint Resolved";
            case COMPLAINT_CLOSED:
                return "Complaint Closed";
            case SYSTEM_ANNOUNCEMENT:
                return "System Announcement";
            default:
                return "Municipal Complaint Update";
        }
    }
    
    public NotificationResponseDto getNotificationById(Long id) {
        Notification notification = notificationRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Notification not found with id: " + id));
        return new NotificationResponseDto(notification);
    }
    
    public List<NotificationResponseDto> getNotificationsByUser(Long userId) {
        List<Notification> notifications = notificationRepository.findByUserIdOrderByCreatedAtDesc(userId);
        return notifications.stream()
            .map(NotificationResponseDto::new)
            .collect(Collectors.toList());
    }
    
    public List<NotificationResponseDto> getNotificationsByComplaint(Long complaintId) {
        List<Notification> notifications = notificationRepository.findByComplaintIdOrderByCreatedAtDesc(complaintId);
        return notifications.stream()
            .map(NotificationResponseDto::new)
            .collect(Collectors.toList());
    }
    
    public List<NotificationResponseDto> getPendingNotifications() {
        List<Notification> notifications = notificationRepository.findPendingNotifications();
        return notifications.stream()
            .map(NotificationResponseDto::new)
            .collect(Collectors.toList());
    }
    
    public List<NotificationResponseDto> getFailedNotifications() {
        List<Notification> notifications = notificationRepository.findFailedNotifications();
        return notifications.stream()
            .map(NotificationResponseDto::new)
            .collect(Collectors.toList());
    }
    
    public void retryFailedNotification(Long notificationId) {
        Notification notification = notificationRepository.findById(notificationId)
            .orElseThrow(() -> new IllegalArgumentException("Notification not found with id: " + notificationId));
        
        if (notification.getDeliveryStatus() == DeliveryStatus.FAILED) {
            // Reset status and retry
            notification.setDeliveryStatus(DeliveryStatus.PENDING);
            notification.setErrorMessage(null);
            notificationRepository.save(notification);
            
            // In a real implementation, you might want to trigger an async retry
        }
    }
    
    public void deleteNotification(Long id) {
        if (!notificationRepository.existsById(id)) {
            throw new IllegalArgumentException("Notification not found with id: " + id);
        }
        notificationRepository.deleteById(id);
    }
}