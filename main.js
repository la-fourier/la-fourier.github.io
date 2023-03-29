const colorThemes = document.querySelector('[name="theme"]');

const storeTheme = function(theme) {
  localStorage.setItem("theme", theme);
};

const retrieveTheme = function() {
  const activeTheme = localStorage.getItem("theme");
  colorThemes.forEach((themeOption) => {
    if (themeOption.id === activeTheme) {
      themeOption.checked = true;
    }
  });
};

colorThemes.forEach(themeOption => {
  themeOption.addEventListener('clic', () => {
    storeTheme(themeOption.id);
  });
});

document.onload = retrieveTheme();
