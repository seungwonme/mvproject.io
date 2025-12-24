"use client";

import React, { useEffect, useState } from 'react';

export default function DynamicBackground() {
    const [mounted, setMounted] = useState(false);

    useEffect(() => {
        setMounted(true);
    }, []);

    if (!mounted) return null;

    return (
        <div className="fixed inset-0 z-[-50] overflow-hidden pointer-events-none bg-black">
            {/* Real Sky Image Background - Adjusted to hide top artifacts */}
            <div
                className="absolute inset-0 bg-cover bg-no-repeat animate-slow-zoom"
                style={{
                    backgroundImage: `url('/sky-bg.png')`,
                    // Shift background up to hide the copied UI header from the reference image
                    backgroundPosition: 'center -100px',
                }}
            />

            {/* Overlay to ensure text readability */}
            <div className="absolute inset-0 bg-black/10" />
        </div>
    );
}
