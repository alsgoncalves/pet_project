const navSlide = () => {
  const burger = document.querySelector('.burger');
  const nav = document.querySelector('.nav-links');
  const navLinks = document.querySelectorAll('.nav-links li');
  const avatar = document.querySelector('.nav-avatar img')
  const avatarLinks = document.querySelector('.avatar-links')

  avatar.addEventListener('click', () => {
    avatarLinks.classList.toggle('avatar-links-active');
  });

  burger.addEventListener('click', () => {
    // Toogle Nav
    nav.classList.toggle('nav-active');

    // Animated Links
    navLinks.forEach((link, index) => {
      if (link.style.animation) {
        link.style.animation = ''
      } else {
        link.style.animation = `navLinkFade 0.5s ease forwards ${index / 7 + 0.5}s`;
      }
    });
    // Burger animation
    burger.classList.toggle('cross');
  });
}

const NavbarOnScroll = () => {
  window.addEventListener('scroll', () => {
    const navbar = document.querySelector('.nav');
    navbar.classList.toggle('sticky', window.scrollY > 0);
  });
}

export { NavbarOnScroll };

export { navSlide };