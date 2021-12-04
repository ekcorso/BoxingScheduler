import UIKit

var html = """
<div class="calendar-prev-next">
    
            <a href="javascript:self.showCalendar('', {offset:15})" class="calendar-next"><span id="class-list-next">More Times</span> <i class="fa fa-chevron-right"></i></a>
    </div>

<table class="class-list table">
    <thead>
        <tr>
            <th>Time</th>
            <th>&nbsp;</th>
            <th>Class</th>
            <th class="class-price-column"></th>
            <th>&nbsp;</th>
        </tr>
    </thead>
    <tbody>
                                                                                        <tr class="class-date-row">
                <td colspan="5"><span class="babel-ignore">Thursday, December 2, 2021</span> <span class="date-head-text margin-left">Today</span></td>
            </tr>
        
        <tr class="class-full visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Cardio Boxing Thursdays (6:15pm)</div>
                                        <label for="appointmentType-20370916" style="display:none">Cardio Boxing Thursdays (6:15pm)</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                <div class="class-spots num-slots-available-container">
                                            no <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row class-full">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">6:15pm</div>
                    <div class="class-duration babel-ignore">1 hour</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                <div class="class-spots num-slots-available-container">
                                            no <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Cardio Boxing Thursdays (6:15pm)</div>
                                <label for="appointmentType-20370916" style="display:none">Cardio Boxing Thursdays (6:15pm)</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: No experience necessary, All levels welcome (Age 14+)<br />
GEAR: Hand wraps, gloves  <br />
<br />
This class is the perfect 60 minute workout! The MBA cardio boxing class is a fun, fast paced calorie burner. This is not aero-boxing or tae bo. Clients will warm up, hit heavy bags, work the punch mitts and get a core workout all in one hour. You will work your arms, legs and core and the best part is that you get to hit stuff without getting hit back. If you're new to the gym please arrive 15 mins early.
            </td>
        </tr>
                                                                    
        <tr class="class-full visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Boxing Skills Thursdays  (With Permission Only)</div>
                                        <label for="appointmentType-20372529" style="display:none">Boxing Skills Thursdays  (With Permission Only)</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                <div class="class-spots num-slots-available-container">
                                            no <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row class-full">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">7:15pm</div>
                    <div class="class-duration babel-ignore">45 minutes</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                <div class="class-spots num-slots-available-container">
                                            no <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Boxing Skills Thursdays  (With Permission Only)</div>
                                <label for="appointmentType-20372529" style="display:none">Boxing Skills Thursdays  (With Permission Only)</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: Invite Only, All levels welcome<br />
GEAR: Hand wraps, Gloves <br />
<br />
The skills class is geared toward fitness clients who want to learn more about the science and technique of boxing. You will learn proper punching technique, as well as the finer points of defense, including  slipping, blocking, ducking, footwork,  and ring generalship.  We also focus on power punching, counter punching, and how to put it all together.  This class includes some partner drills but is non-contact (no sparring).
            </td>
        </tr>
                                                                                            <tr class="class-date-row">
                <td colspan="5"><span class="babel-ignore">Friday, December 3, 2021</span> <span class="date-head-text margin-left">Tomorrow</span></td>
            </tr>
        
        <tr class=" visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Morning Body Blast Fridays (With Permission Only)</div>
                                        <label for="appointmentType-20370636" style="display:none">Morning Body Blast Fridays (With Permission Only)</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-type="20370636" data-calendar="4131473" data-time="2021-12-03 06:30" data-readable-date="December 3, 2021" data-readable-time="6:30am">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">10</span> <span id="spots-left-text" data-qa="select-class-button">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row ">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">6:30am</div>
                    <div class="class-duration babel-ignore">1 hour</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-qa="class-signup-20370636-button" data-type="20370636" data-calendar="4131473" data-time="2021-12-03 06:30" data-readable-date="December 3, 2021" data-readable-time="6:30am">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">10</span> <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Morning Body Blast Fridays (With Permission Only)</div>
                                <label for="appointmentType-20370636" style="display:none">Morning Body Blast Fridays (With Permission Only)</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: Invite Only, All levels welcome<br />
Gear: Hand wraps, Gloves<br />
<br />
Start your day off right! This 45 minute class is an awesome fat burning, muscle building morning workout. The class includes boxing, kettle bells, TRX, plyometrics, core work and body weight exercises. Each class is unique and will target different body areas. For all of you early birds out there, this is a great way to kick start your metabolism and prepare your body and mind for a productive day. All fitness levels welcome.
            </td>
        </tr>
                                                                    
        <tr class=" visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Combat Conditioning Fridays</div>
                                        <label for="appointmentType-20371089" style="display:none">Combat Conditioning Fridays</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-type="20371089" data-calendar="4131473" data-time="2021-12-03 17:00" data-readable-date="December 3, 2021" data-readable-time="5:00pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">3</span> <span id="spots-left-text" data-qa="select-class-button">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row ">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">5:00pm</div>
                    <div class="class-duration babel-ignore">1 hour</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-qa="class-signup-20371089-button" data-type="20371089" data-calendar="4131473" data-time="2021-12-03 17:00" data-readable-date="December 3, 2021" data-readable-time="5:00pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">3</span> <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Combat Conditioning Fridays</div>
                                <label for="appointmentType-20371089" style="display:none">Combat Conditioning Fridays</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: All levels welcome<br />
GEAR: None<br />
<br />
Combat Conditioning Class is MBA's version of a mini boxing boot camp! The focus is on the fat burning, muscle building workouts boxers use to help condition themselves for competition. The class includes circuit training with weights, medicine balls, resistance bands, plyometric boxes, TRX and more.
            </td>
        </tr>
                                                                    
        <tr class=" visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Team Practice Fridays (With Permission Only)</div>
                                        <label for="appointmentType-20372892" style="display:none">Team Practice Fridays (With Permission Only)</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-type="20372892" data-calendar="4131473" data-time="2021-12-03 18:00" data-readable-date="December 3, 2021" data-readable-time="6:00pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">6</span> <span id="spots-left-text" data-qa="select-class-button">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row ">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">6:00pm</div>
                    <div class="class-duration babel-ignore">2 hours</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-qa="class-signup-20372892-button" data-type="20372892" data-calendar="4131473" data-time="2021-12-03 18:00" data-readable-date="December 3, 2021" data-readable-time="6:00pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">6</span> <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Team Practice Fridays (With Permission Only)</div>
                                <label for="appointmentType-20372892" style="display:none">Team Practice Fridays (With Permission Only)</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: Invite Only <br />
GEAR: Hand Wraps, Sparring Gloves Mouthpiece, Cup, Headgear (pros must bring and use their own equipment).<br />
<br />
The team workout and sparring sessions are held twice a week for registered amateur boxers and pro boxers. This is a dedicated sparring and training time for the boxers. If you would like to compete, you must speak with the coach.
            </td>
        </tr>
                                                                                            <tr class="class-date-row">
                <td colspan="5"><span class="babel-ignore">Saturday, December 4, 2021</span> <span class="date-head-text margin-left"></span></td>
            </tr>
        
        <tr class="class-full visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Cardio Boxing Saturdays (9am)</div>
                                        <label for="appointmentType-20370954" style="display:none">Cardio Boxing Saturdays (9am)</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                <div class="class-spots num-slots-available-container">
                                            no <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row class-full">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">9:00am</div>
                    <div class="class-duration babel-ignore">1 hour</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                <div class="class-spots num-slots-available-container">
                                            no <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Cardio Boxing Saturdays (9am)</div>
                                <label for="appointmentType-20370954" style="display:none">Cardio Boxing Saturdays (9am)</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: No experience necessary, All levels welcome (Age 14+)<br />
GEAR: Hand wraps, gloves  <br />
<br />
This class is the perfect 60 minute workout! The MBA cardio boxing class is a fun, fast paced calorie burner. This is not aero-boxing or tae bo. Clients will warm up, hit heavy bags, work the punch mitts and get a core workout all in one hour. You will work your arms, legs and core and the best part is that you get to hit stuff without getting hit back. If you're new to the gym please arrive 15 mins early.
            </td>
        </tr>
                                                                    
        <tr class="class-full visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Cardio Boxing Saturdays (10:30am)</div>
                                        <label for="appointmentType-20370984" style="display:none">Cardio Boxing Saturdays (10:30am)</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                <div class="class-spots num-slots-available-container">
                                            no <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row class-full">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">10:30am</div>
                    <div class="class-duration babel-ignore">1 hour</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                <div class="class-spots num-slots-available-container">
                                            no <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Cardio Boxing Saturdays (10:30am)</div>
                                <label for="appointmentType-20370984" style="display:none">Cardio Boxing Saturdays (10:30am)</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: No experience necessary, All levels welcome (Age 14+)<br />
GEAR: Hand wraps, gloves  <br />
<br />
This class is the perfect 60 minute workout! The MBA cardio boxing class is a fun, fast paced calorie burner. This is not aero-boxing or tae bo. Clients will warm up, hit heavy bags, work the punch mitts and get a core workout all in one hour. You will work your arms, legs and core and the best part is that you get to hit stuff without getting hit back. If you're new to the gym please arrive 15 mins early.
            </td>
        </tr>
                                                                                            <tr class="class-date-row">
                <td colspan="5"><span class="babel-ignore">Monday, December 6, 2021</span> <span class="date-head-text margin-left">Next Week</span></td>
            </tr>
        
        <tr class=" visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Morning Body Blast Mondays (With Permission Only)</div>
                                        <label for="appointmentType-20370754" style="display:none">Morning Body Blast Mondays (With Permission Only)</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-type="20370754" data-calendar="4131473" data-time="2021-12-06 06:30" data-readable-date="December 6, 2021" data-readable-time="6:30am">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">11</span> <span id="spots-left-text" data-qa="select-class-button">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row ">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">6:30am</div>
                    <div class="class-duration babel-ignore">1 hour</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-qa="class-signup-20370754-button" data-type="20370754" data-calendar="4131473" data-time="2021-12-06 06:30" data-readable-date="December 6, 2021" data-readable-time="6:30am">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">11</span> <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Morning Body Blast Mondays (With Permission Only)</div>
                                <label for="appointmentType-20370754" style="display:none">Morning Body Blast Mondays (With Permission Only)</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: Invite Only, All levels welcome<br />
Gear: Hand wraps, Gloves<br />
<br />
Start your day off right! This 45 minute class is an awesome fat burning, muscle building morning workout. The class includes boxing, kettle bells, TRX, plyometrics, core work and body weight exercises. Each class is unique and will target different body areas. For all of you early birds out there, this is a great way to kick start your metabolism and prepare your body and mind for a productive day. All fitness levels welcome.
            </td>
        </tr>
                                                                    
        <tr class=" visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Footwork FUNdamentals Mondays  (With Permission Only)</div>
                                        <label for="appointmentType-15214668" style="display:none">Footwork FUNdamentals Mondays  (With Permission Only)</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-type="15214668" data-calendar="4131473" data-time="2021-12-06 17:00" data-readable-date="December 6, 2021" data-readable-time="5:00pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">2</span> <span id="spots-left-text" data-qa="select-class-button">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row ">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">5:00pm</div>
                    <div class="class-duration babel-ignore">1 hour</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-qa="class-signup-15214668-button" data-type="15214668" data-calendar="4131473" data-time="2021-12-06 17:00" data-readable-date="December 6, 2021" data-readable-time="5:00pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">2</span> <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Footwork FUNdamentals Mondays  (With Permission Only)</div>
                                <label for="appointmentType-15214668" style="display:none">Footwork FUNdamentals Mondays  (With Permission Only)</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: Invite Only, All levels welcome<br />
Gear:  Hand Wraps, Gloves<br />
<br />
Proper footwork in boxing is every bit as important as proper punching technique. In this class you will learn how to get into the correct positions to defend and attack. The focus of this class is  movement, balance, strength, coordination, timing, speed, power and the tactical techniques to put them all together. If you want to sting like a bee, you have to learn to float like a butterfly.
            </td>
        </tr>
                                                                                            <tr class="class-date-row">
                <td colspan="5"><span class="babel-ignore">Tuesday, December 7, 2021</span> <span class="date-head-text margin-left"></span></td>
            </tr>
        
        <tr class=" visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Lunch-Time Boxing Power Hour Tuesdays</div>
                                        <label for="appointmentType-15214752" style="display:none">Lunch-Time Boxing Power Hour Tuesdays</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-type="15214752" data-calendar="4131473" data-time="2021-12-07 12:00" data-readable-date="December 7, 2021" data-readable-time="12:00pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">5</span> <span id="spots-left-text" data-qa="select-class-button">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row ">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">12:00pm</div>
                    <div class="class-duration babel-ignore">1 hour</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-qa="class-signup-15214752-button" data-type="15214752" data-calendar="4131473" data-time="2021-12-07 12:00" data-readable-date="December 7, 2021" data-readable-time="12:00pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">5</span> <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Lunch-Time Boxing Power Hour Tuesdays</div>
                                <label for="appointmentType-15214752" style="display:none">Lunch-Time Boxing Power Hour Tuesdays</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: No experience necessary, All levels welcome (Age 14+)<br />
Gear:  Hand Wraps, Gloves<br />
<br />
Come take a mid-day break from your endless zoom meetings! This class is a version of our Cardio Boxing Class with some full body training thrown in. Get your bag rounds in and kill those abs and legs, all in time to go back and finish your work day. If you're new to the gym please arrive 15 mins early.
            </td>
        </tr>
                                                                    
        <tr class=" visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Cardio Boxing Tuesdays (5pm)</div>
                                        <label for="appointmentType-15214695" style="display:none">Cardio Boxing Tuesdays (5pm)</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-type="15214695" data-calendar="4131473" data-time="2021-12-07 17:00" data-readable-date="December 7, 2021" data-readable-time="5:00pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">1</span> <span id="spots-left-text" data-qa="select-class-button">spot left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row ">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">5:00pm</div>
                    <div class="class-duration babel-ignore">1 hour</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-qa="class-signup-15214695-button" data-type="15214695" data-calendar="4131473" data-time="2021-12-07 17:00" data-readable-date="December 7, 2021" data-readable-time="5:00pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">1</span> <span id="spots-left-text">spot left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Cardio Boxing Tuesdays (5pm)</div>
                                <label for="appointmentType-15214695" style="display:none">Cardio Boxing Tuesdays (5pm)</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: No experience necessary, All levels welcome (Age 14+)<br />
GEAR: Hand wraps, gloves  <br />
<br />
This class is the perfect 60 minute workout! The MBA cardio boxing class is a fun, fast paced calorie burner. This is not aero-boxing or tae bo. Clients will warm up, hit heavy bags, work the punch mitts and get a core workout all in one hour. You will work your arms, legs and core and the best part is that you get to hit stuff without getting hit back. If you're new to the gym please arrive 15 mins early.
            </td>
        </tr>
                                                                    
        <tr class="class-full visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Cardio Boxing Tuesdays (6:15pm)</div>
                                        <label for="appointmentType-20370849" style="display:none">Cardio Boxing Tuesdays (6:15pm)</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                <div class="class-spots num-slots-available-container">
                                            no <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row class-full">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">6:15pm</div>
                    <div class="class-duration babel-ignore">1 hour</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                <div class="class-spots num-slots-available-container">
                                            no <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Cardio Boxing Tuesdays (6:15pm)</div>
                                <label for="appointmentType-20370849" style="display:none">Cardio Boxing Tuesdays (6:15pm)</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: No experience necessary, All levels welcome (Age 14+)<br />
GEAR: Hand wraps, gloves  <br />
<br />
This class is the perfect 60 minute workout! The MBA cardio boxing class is a fun, fast paced calorie burner. This is not aero-boxing or tae bo. Clients will warm up, hit heavy bags, work the punch mitts and get a core workout all in one hour. You will work your arms, legs and core and the best part is that you get to hit stuff without getting hit back. If you're new to the gym please arrive 15 mins early.
            </td>
        </tr>
                                                                    
        <tr class=" visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Boxing Skills Tuesdays  (With Permission Only)</div>
                                        <label for="appointmentType-16352062" style="display:none">Boxing Skills Tuesdays  (With Permission Only)</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-type="16352062" data-calendar="4131473" data-time="2021-12-07 19:15" data-readable-date="December 7, 2021" data-readable-time="7:15pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">2</span> <span id="spots-left-text" data-qa="select-class-button">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row ">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">7:15pm</div>
                    <div class="class-duration babel-ignore">45 minutes</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-qa="class-signup-16352062-button" data-type="16352062" data-calendar="4131473" data-time="2021-12-07 19:15" data-readable-date="December 7, 2021" data-readable-time="7:15pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">2</span> <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Boxing Skills Tuesdays  (With Permission Only)</div>
                                <label for="appointmentType-16352062" style="display:none">Boxing Skills Tuesdays  (With Permission Only)</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: Invite Only, All levels welcome<br />
GEAR: Hand wraps, Gloves <br />
<br />
The skills class is geared toward fitness clients who want to learn more about the science and technique of boxing. You will learn proper punching technique, as well as the finer points of defense, including  slipping, blocking, ducking, footwork,  and ring generalship.  We also focus on power punching, counter punching, and how to put it all together.  This class includes some partner drills but is non-contact (no sparring).
            </td>
        </tr>
                                                                                            <tr class="class-date-row">
                <td colspan="5"><span class="babel-ignore">Wednesday, December 8, 2021</span> <span class="date-head-text margin-left"></span></td>
            </tr>
        
        <tr class=" visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Morning Body Blast Wednesdays (With Permission Only)</div>
                                        <label for="appointmentType-15214624" style="display:none">Morning Body Blast Wednesdays (With Permission Only)</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-type="15214624" data-calendar="4131473" data-time="2021-12-08 06:30" data-readable-date="December 8, 2021" data-readable-time="6:30am">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">11</span> <span id="spots-left-text" data-qa="select-class-button">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row ">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">6:30am</div>
                    <div class="class-duration babel-ignore">1 hour</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-qa="class-signup-15214624-button" data-type="15214624" data-calendar="4131473" data-time="2021-12-08 06:30" data-readable-date="December 8, 2021" data-readable-time="6:30am">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">11</span> <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Morning Body Blast Wednesdays (With Permission Only)</div>
                                <label for="appointmentType-15214624" style="display:none">Morning Body Blast Wednesdays (With Permission Only)</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: Invite Only, All levels welcome<br />
Gear: Hand wraps, Gloves<br />
<br />
Start your day off right! This 45 minute class is an awesome fat burning, muscle building morning workout. The class includes boxing, kettle bells, TRX, plyometrics, core work and body weight exercises. Each class is unique and will target different body areas. For all of you early birds out there, this is a great way to kick start your metabolism and prepare your body and mind for a productive day. All fitness levels welcome.
            </td>
        </tr>
                                                                    
        <tr class=" visible-xs class-row-xs">
            <td style="border:none">
                <div class="babel-ignore">
                    <div class="class-name">Combat Conditioning Wednesdays</div>
                                        <label for="appointmentType-15214860" style="display:none">Combat Conditioning Wednesdays</strong>
                </div>
                <div class="class-price-column">
                                        <div class="class-space"></div>
                </div>
            </td>
            <td class="class-signup-container">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-type="15214860" data-calendar="4131473" data-time="2021-12-08 17:00" data-readable-date="December 8, 2021" data-readable-time="5:00pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">2</span> <span id="spots-left-text" data-qa="select-class-button">spots left</span>
                     
                </div>
            </td>
        </tr>

        <tr class="class-class-row ">
            <td class="times-column">
                                                        <div class="class-time babel-ignore">5:00pm</div>
                    <div class="class-duration babel-ignore">1 hour</div>
                                </div>
            </td>

            <td class="class-signup-container hidden-xs">
                                                            <a href="#" class="btn btn-primary btn-class-signup" data-qa="class-signup-15214860-button" data-type="15214860" data-calendar="4131473" data-time="2021-12-08 17:00" data-readable-date="December 8, 2021" data-readable-time="5:00pm">Sign up</a>
                                                    <div class="class-spots num-slots-available-container">
                                            <span class="babel-ignore">2</span> <span id="spots-left-text">spots left</span>
                     
                </div>
            </td>

            <td class="babel-ignore hidden-xs">
                <div class="class-name">Combat Conditioning Wednesdays</div>
                                <label for="appointmentType-15214860" style="display:none">Combat Conditioning Wednesdays</strong>
            </td>
            <td class="class-price-column hidden-xs">
                                <div class="class-space"></div>
            </td>
            <td class="babel-ignore class-image-column" >
                                <div class="class-space"></div>
            </td>

        </tr>
                <tr class="class-description-row">
            <td colspan="4" class="class-separator">
                Level: All levels welcome<br />
GEAR: None<br />
<br />
Combat Conditioning Class is MBA's version of a mini boxing boot camp! The focus is on the fat burning, muscle building workouts boxers use to help condition themselves for competition. The class includes circuit training with weights, medicine balls, resistance bands, plyometric boxes, TRX and more.
            </td>
        </tr>
                </tbody>
</table>

<div class="calendar-prev-next">
    
            <a href="javascript:self.showCalendar('', {offset:15})" class="calendar-next"><span id="class-list-next">More Times</span> <i class="fa fa-chevron-right"></i></a>
    </div>

"""
