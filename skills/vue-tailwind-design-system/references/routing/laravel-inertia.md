# Laravel + Inertia (Vue)

Inertia resolves a page component by name from a server-side route. The route registration is PHP — **print the snippet and let the user paste it; do not auto-edit PHP files.**

1. The page component is written to `resources/js/Pages/Admin/DesignSystem.vue` (it imports and renders the `DesignSystem` component, or *is* that component).

2. Add a route to `routes/web.php`:

```php
use Inertia\Inertia;

Route::get('__ROUTE_PATH__', fn () => Inertia::render('Admin/DesignSystem'))
    ->name('design-system');
```

The string passed to `Inertia::render` is the page name relative to `resources/js/Pages/` (no extension), so `'Admin/DesignSystem'` resolves to `resources/js/Pages/Admin/DesignSystem.vue`.

3. If the app gates admin routes behind middleware (e.g. `auth`), tell the user to wrap the route accordingly:

```php
Route::middleware(['auth'])->group(function () {
    Route::get('__ROUTE_PATH__', fn () => Inertia::render('Admin/DesignSystem'))
        ->name('design-system');
});
```

Print the snippet and the exact file to paste it into; do not modify `routes/web.php` automatically.
