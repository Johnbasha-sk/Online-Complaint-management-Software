    <!-- Footer -->
    <footer class="bg-dark text-light mt-5 py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-3">
                    <h5 class="text-primary">
                        <i class="bi bi-building"></i>
                        Municipal Complaints System
                    </h5>
                    <p class="text-muted">
                        Empowering citizens to report and track municipal issues efficiently.
                        Building better communities through transparent communication.
                    </p>
                </div>
                
                <div class="col-md-4 mb-3">
                    <h6 class="text-primary">Quick Links</h6>
                    <ul class="list-unstyled">
                        <li><a href="/" class="text-muted text-decoration-none">Home</a></li>
                        <li><a href="/about" class="text-muted text-decoration-none">About Us</a></li>
                        <li><a href="/contact" class="text-muted text-decoration-none">Contact</a></li>
                        <li><a href="/help" class="text-muted text-decoration-none">Help & Support</a></li>
                    </ul>
                </div>
                
                <div class="col-md-4 mb-3">
                    <h6 class="text-primary">Contact Information</h6>
                    <ul class="list-unstyled text-muted">
                        <li><i class="bi bi-geo-alt"></i> 123 Municipal St, City, State 12345</li>
                        <li><i class="bi bi-telephone"></i> (555) 123-4567</li>
                        <li><i class="bi bi-envelope"></i> complaints@municipal.gov</li>
                        <li><i class="bi bi-clock"></i> Mon-Fri: 8:00 AM - 5:00 PM</li>
                    </ul>
                </div>
            </div>
            
            <hr class="my-3">
            
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="text-muted mb-0">
                        &copy; 2024 Municipal Complaints System. All rights reserved.
                    </p>
                </div>
                <div class="col-md-6 text-md-end">
                    <div class="social-links">
                        <a href="#" class="text-muted me-3" title="Facebook">
                            <i class="bi bi-facebook fs-5"></i>
                        </a>
                        <a href="#" class="text-muted me-3" title="Twitter">
                            <i class="bi bi-twitter fs-5"></i>
                        </a>
                        <a href="#" class="text-muted me-3" title="LinkedIn">
                            <i class="bi bi-linkedin fs-5"></i>
                        </a>
                        <a href="#" class="text-muted" title="Instagram">
                            <i class="bi bi-instagram fs-5"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    
    <!-- Back to Top Button -->
    <button id="backToTop" class="btn btn-primary position-fixed bottom-0 end-0 m-3 d-none" 
            style="z-index: 1000; bottom: 20px; right: 20px;">
        <i class="bi bi-arrow-up"></i>
    </button>
    
    <!-- Custom JavaScript for Back to Top -->
    <script>
        // Back to top functionality
        const backToTopButton = document.getElementById('backToTop');
        
        window.addEventListener('scroll', () => {
            if (window.pageYOffset > 300) {
                backToTopButton.classList.remove('d-none');
            } else {
                backToTopButton.classList.add('d-none');
            }
        });
        
        backToTopButton.addEventListener('click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
        
        // Social media links hover effect
        document.querySelectorAll('.social-links a').forEach(link => {
            link.addEventListener('mouseenter', function() {
                this.classList.remove('text-muted');
                this.classList.add('text-primary');
            });
            
            link.addEventListener('mouseleave', function() {
                this.classList.remove('text-primary');
                this.classList.add('text-muted');
            });
        });
    </script>
</body>
</html>