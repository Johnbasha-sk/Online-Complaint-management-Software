package com.municipal.user.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Component
public class JwtUtil {

    private final Key signingKey;
    private final long expirationMillis;

    public JwtUtil(@Value("${jwt.secret}") String secret,
                   @Value("${jwt.expirationSeconds}") long expirationSeconds) {
        this.signingKey = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
        this.expirationMillis = expirationSeconds * 1000L;
    }

    public String generateToken(Long userId, String username, List<String> roles) {
        long now = System.currentTimeMillis();
        return Jwts.builder()
                .setSubject(username)
                .addClaims(Map.of(
                        "userId", userId,
                        "username", username,
                        "roles", roles
                ))
                .setIssuedAt(new Date(now))
                .setExpiration(new Date(now + expirationMillis))
                .signWith(signingKey, SignatureAlgorithm.HS256)
                .compact();
    }

    public Claims parse(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(signingKey)
                .build()
                .parseClaimsJws(token)
                .getBody();
    }
}