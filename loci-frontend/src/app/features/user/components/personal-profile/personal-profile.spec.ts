import { ComponentFixture, TestBed } from '@angular/core/testing';
import { PersonalProfile } from './personal-profile';


describe('PersonalProfile', () => {
  let component: PersonalProfile;
  let fixture: ComponentFixture<PersonalProfile>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PersonalProfile]
    })
      .compileComponents();

    fixture = TestBed.createComponent(PersonalProfile);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
