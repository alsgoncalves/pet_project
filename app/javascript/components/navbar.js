const navSlide = () => {
  const burger = document.querySelector('.burger');
  const nav = document.querySelector('.nav-links');
  const navLinks = document.querySelectorAll('.nav-links li');
  const avatar = document.querySelector('.nav-avatar img')
  const avatarLinks = document.querySelector('.avatar-links')

  const burgerClick= burger.addEventListener('click', () => {
    if (avatarLinks.classList.contains("avatar-links-active")) {
      avatarLinks.classList.remove("avatar-links-active");
    };

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

  const avatarClick = avatar.addEventListener('click', () => {
    if (nav.classList.contains("nav-active")) {
      nav.classList.toggle("nav-active");

      navLinks.forEach((link, index) => {
        if (link.style.animation) {
          link.style.animation = ''
        } else {
          link.style.animation = `navLinkFade 0.5s ease forwards ${index / 7 + 0.5}s`;
        }
      });
    };

    avatarLinks.classList.toggle('avatar-links-active');
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
