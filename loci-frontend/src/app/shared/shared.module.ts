import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule } from '@angular/forms';
import { AvatarComponent } from './components/avatar/avatar';

// Import standalone components

/**
 * SharedModule - Optional export module for shared components
 * Note: Since we're using standalone components, this module is optional.
 * Components can be imported directly in other standalone components.
 * This module exists for convenience when importing multiple shared components.
 */
@NgModule({
  imports: [
    // CommonModule,
    ReactiveFormsModule,
    // Import standalone components
    AvatarComponent,
  ],
  exports: [
    // Re-export for convenience
    CommonModule,
    ReactiveFormsModule,
    AvatarComponent,
  ]
})
export class SharedModule { }

/**
 * Standalone Components Array
 * Use this array to import all shared components at once in standalone components
 *
 * Usage:
 * @Component({
 *   imports: [...SHARED_COMPONENTS]
 * })
 */
export const SHARED_COMPONENTS = [
  AvatarComponent,
] as const;
