// pm2 start ecosystem.config.js --env production
// ÖNEMLİ: instances 1 kalmalı. Çevrimiçi kullanıcılar ve eşleştirme kuyruğu bellekte tutuluyor;
// birden fazla süreç olursa kullanıcılar birbirini göremez.
module.exports = {
  apps: [
    {
      name: 'veylo-api',
      script: 'dist/server.js',
      instances: 1,
      exec_mode: 'fork',
      max_memory_restart: '600M',
      kill_timeout: 5000,
      time: true,
      env_production: {
        NODE_ENV: 'production',
      },
    },
  ],
};
