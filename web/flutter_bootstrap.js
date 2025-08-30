// Flutter injects these at build time:
{{flutter_js}}
{{flutter_build_config}}

// Optional: if you want explicit SW config, use the token (no quotes):
// const serviceWorkerVersion = {{flutter_service_worker_version}};

const loadingEl = document.getElementById('loading');

_flutter.loader.load({
  // If you enable SW explicitly, pass:
  // serviceWorker: { serviceWorkerVersion },
  onEntrypointLoaded: async (engineInitializer) => {
    try {
      loadingEl && (loadingEl.querySelector('.loading-content div:last-child').textContent = 'Initializing…');
    } catch (_) {}
    const appRunner = await engineInitializer.initializeEngine();
    try {
      loadingEl && (loadingEl.querySelector('.loading-content div:last-child').textContent = 'Launching…');
    } catch (_) {}
    await appRunner.runApp();
    // Remove the overlay after first frame
    requestAnimationFrame(() => loadingEl?.remove());
  },
});
