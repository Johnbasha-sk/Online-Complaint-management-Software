package com.municipal.notification.repository;

import com.municipal.notification.Notification;
import com.municipal.notification.entity.DeliveryStatus;
import com.municipal.notification.entity.NotificationChannel;
import com.municipal.notification.entity.NotificationType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {
    
    List<Notification> findByUserIdOrderByCreatedAtDesc(Long userId);
    
    List<Notification> findByComplaintIdOrderByCreatedAtDesc(Long complaintId);
    
    List<Notification> findByTypeAndDeliveryStatus(NotificationType type, DeliveryStatus deliveryStatus);
    
    List<Notification> findByChannelAndDeliveryStatus(NotificationChannel channel, DeliveryStatus deliveryStatus);
    
    @Query("SELECT n FROM Notification n WHERE n.createdAt >= :startDate AND n.createdAt <= :endDate")
    List<Notification> findByDateRange(@Param("startDate") LocalDateTime startDate, 
                                     @Param("endDate") LocalDateTime endDate);
    
    @Query("SELECT n FROM Notification n WHERE n.deliveryStatus = :status ORDER BY n.createdAt DESC")
    Page<Notification> findByDeliveryStatus(@Param("status") DeliveryStatus status, Pageable pageable);
    
    @Query("SELECT COUNT(n) FROM Notification n WHERE n.userId = :userId AND n.deliveryStatus = :status")
    Long countByUserIdAndDeliveryStatus(@Param("userId") Long userId, @Param("status") DeliveryStatus status);
    
    @Query("SELECT n FROM Notification n WHERE n.deliveryStatus = 'PENDING' ORDER BY n.createdAt ASC")
    List<Notification> findPendingNotifications();
    
    @Query("SELECT n FROM Notification n WHERE n.deliveryStatus = 'FAILED' ORDER BY n.createdAt DESC")
    List<Notification> findFailedNotifications();
}