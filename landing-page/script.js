/**
 * AIDA Landing Page Scripts
 * Handle intersection observers for scroll animations and dynamic behaviors
 */

document.addEventListener('DOMContentLoaded', () => {
    
    // 1. Setup Intersection Observer for fade-in animations
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.15 // Triggers when 15% of the element is visible
    };

    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                // Add the 'visible' class to trigger CSS transition
                entry.target.classList.add('visible');
                // Stop observing once animated to avoid re-triggering
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    // Get all elements with the fade-in-up class
    const animatedElements = document.querySelectorAll('.fade-in-up');
    
    // Start observing each element
    animatedElements.forEach(el => observer.observe(el));


    // 2. Add smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;
            
            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                // Adjust for fixed navbar height (~80px)
                const headerOffset = 80;
                const elementPosition = targetElement.getBoundingClientRect().top;
                const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
  
                window.scrollTo({
                     top: offsetPosition,
                     behavior: "smooth"
                });
            }
        });
    });

    // 3. App Link Injector (Placeholder behavior)
    // Replace this string with the final LibreChat Railway URL later
    const aidaAppUrl = "https://your-aida-app.railway.app";
    
    // Attach to primary CTA buttons
    const ctaButtons = document.querySelectorAll('.btn-primary, .btn-secondary');
    ctaButtons.forEach(btn => {
        if(btn.getAttribute('href') === '#') {
            btn.setAttribute('href', aidaAppUrl);
            btn.setAttribute('target', '_blank'); // Opens chat in new tab
        }
    });

});
