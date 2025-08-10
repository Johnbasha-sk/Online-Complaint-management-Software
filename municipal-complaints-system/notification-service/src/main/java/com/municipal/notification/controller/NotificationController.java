package com.municipal.notification.controller;

import com.municipal.notification.dto.NotificationRequestDto;
import com.municipal.notification.dto.NotificationResponseDto;
import com.municipal.notification.service.NotificationService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/notifications")
@CrossOrigin(origins = "*")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @PostMapping("/send")
    @PreAuthorize("hasAnyRole('STAFF', 'ADMIN')")
    public ResponseEntity<NotificationResponseDto> sendNotification(@Valid @RequestBody NotificationRequestDto requestDto) {
        NotificationResponseDto response = notificationService.sendNotification(requestDto);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('STAFF', 'ADMIN')")
    public ResponseEntity<NotificationResponseDto> getNotificationById(@PathVariable Long id) {
        NotificationResponseDto response = notificationService.getNotificationById(id);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/user/{userId}")
    @PreAuthorize("hasAnyRole('STAFF', 'ADMIN')")
    public ResponseEntity<List<NotificationResponseDto>> getNotificationsByUser(@PathVariable Long userId) {
        List<NotificationResponseDto> notifications = notificationService.getNotificationsByUser(userId);
        return ResponseEntity.ok(notifications);
    }

    @GetMapping("/complaint/{complaintId}")
    @PreAuthorize("hasAnyRole('STAFF', 'ADMIN')")
    public ResponseEntity<List<NotificationResponseDto>> getNotificationsByComplaint(@PathVariable Long complaintId) {
        List<NotificationResponseDto> notifications = notificationService.getNotificationsByComplaint(complaintId);
        return ResponseEntity.ok(notifications);
    }

    @GetMapping("/pending")
    @PreAuthorize("hasAnyRole('STAFF', 'ADMIN')")
    public ResponseEntity<List<NotificationResponseDto>> getPendingNotifications() {
        List<NotificationResponseDto> notifications = notificationService.getPendingNotifications();
        return ResponseEntity.ok(notifications);
    }

    @GetMapping("/failed")
    @PreAuthorize("hasAnyRole('STAFF', 'ADMIN')")
    public ResponseEntity<List<NotificationResponseDto>> getFailedNotifications() {
        List<NotificationResponseDto> notifications = notificationService.getFailedNotifications();
        return ResponseEntity.ok(notifications);
    }

    @PostMapping("/{id}/retry")
    @PreAuthorize("hasAnyRole('STAFF', 'ADMIN')")
    public ResponseEntity<Void> retryFailedNotification(@PathVariable Long id) {
        notificationService.retryFailedNotification(id);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> deleteNotification(@PathVariable Long id) {
        notificationService.deleteNotification(id);
        return ResponseEntity.ok().build();
    }
}