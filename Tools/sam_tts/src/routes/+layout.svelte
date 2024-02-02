<script lang="ts">
    import { ModeWatcher } from "mode-watcher";
    import "../app.pcss";
    import { LightSwitch } from "$lib/components/ui/light-switch";
</script>

<header class="flex p-4">
    <h1 class="text-4xl font-bold">sam_tts</h1>
    <div class="flex-1"></div>
    <LightSwitch />
</header>

<ModeWatcher />

<slot />
