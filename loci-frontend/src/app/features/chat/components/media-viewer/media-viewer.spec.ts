import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MediaViewer } from './media-viewer';

describe('MediaViewer', () => {
  let component: MediaViewer;
  let fixture: ComponentFixture<MediaViewer>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MediaViewer]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MediaViewer);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
