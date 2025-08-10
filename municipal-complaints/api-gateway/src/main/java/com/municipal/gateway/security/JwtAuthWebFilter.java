package com.municipal.gateway.security;

import io.jsonwebtoken.Claims;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.WebFilter;
import org.springframework.web.server.WebFilterChain;
import reactor.core.publisher.Mono;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import static org.springframework.security.core.context.ReactiveSecurityContextHolder.withAuthentication;

@Component
public class JwtAuthWebFilter implements WebFilter {

    private final JwtUtil jwtUtil;

    public JwtAuthWebFilter(@Value("${jwt.secret}") String secret) {
        this.jwtUtil = new JwtUtil(secret);
    }

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, WebFilterChain chain) {
        String token = resolveToken(exchange);
        if (token == null || token.isEmpty()) {
            return chain.filter(exchange);
        }
        try {
            Claims claims = jwtUtil.parseAndValidate(token);
            String username = claims.getSubject();
            Object rolesObj = claims.get("roles");
            List<String> roles = rolesObj instanceof List ? (List<String>) rolesObj : List.of();
            Collection<GrantedAuthority> authorities = roles.stream()
                    .map(r -> r.startsWith("ROLE_") ? r : "ROLE_" + r)
                    .map(SimpleGrantedAuthority::new)
                    .collect(Collectors.toList());
            AbstractAuthenticationToken auth = new AbstractAuthenticationToken(authorities) {
                @Override
                public Object getCredentials() { return token; }
                @Override
                public Object getPrincipal() { return username; }
            };
            auth.setAuthenticated(true);
            return chain.filter(exchange).contextWrite(withAuthentication(auth));
        } catch (Exception ex) {
            return chain.filter(exchange);
        }
    }

    private String resolveToken(ServerWebExchange exchange) {
        String header = exchange.getRequest().getHeaders().getFirst(HttpHeaders.AUTHORIZATION);
        if (header != null && header.startsWith("Bearer ")) {
            return header.substring(7);
        }
        if (exchange.getRequest().getCookies().getFirst("JWT") != null) {
            return exchange.getRequest().getCookies().getFirst("JWT").getValue();
        }
        return null;
    }
}