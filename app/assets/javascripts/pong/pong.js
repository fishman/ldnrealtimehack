/*global window, YUI, ARNIE, PONG */
"use strict";

var state = {
  currentY: 0,
  lastY: undefined,
  p1score: 0,
  p2score: 0,
  syncBlock: undefined
};



YUI().use('node', 'event-custom', function (Y) {
    window.PONG = (function () {
        var canvas = window.document.getElementById('pong'),
        game = ARNIE.game(canvas, Y),

        player1 = {
            score: 0
        },

        player2 = {
            score: 0
        },

        ping = undefined,/* pong is the response we get from the right side */
        pong = undefined,/* ping is the response we get from the left side */
        defaultTimeout = 10,


        ball = game.sprite('ball', {
            detectCollisions: true,

            move: function () {
                this.place(this.x + this.xPixelsPerTick, this.y + this.yPixelsPerTick);
            },
            reverseX: function () {
                this.xPixelsPerTick = 0 - this.xPixelsPerTick;
            },
            reverseY: function () {
                this.yPixelsPerTick = 0 - this.yPixelsPerTick;
            },
            width: 32,
            height: 32
        }),

        paddle1 = game.sprite('paddle1', {
            width: 32,
            height: 128,
            fillStyle: 'blue',
            setY: function (y) {
                var lowest = canvas.height - this.height;

                // simple object used to store next position
                this.next = {
                    place: this.place
                };

                if (y < 0) {
                    this.next.place(this.x, 0);
                } else if (y > lowest) {
                    this.next.place(this.x, lowest);
                } else {
                    this.next.place(this.x, y);
                }

                return this;
            },
            move: function () {
                if (this.next) {
                    this.place(this.next.x, this.next.y);
                }
                return this;
            }
        }),

        paddle2 = game.sprite('paddle2', paddle1),

        top = game.sprite('top', {
            width: canvas.width,
            height: 1
        }),

        bottom = game.sprite('bottom', {
            width: canvas.width,
            height: 1
        }),

        left = game.sprite('left', {
            width: 1,
            height: canvas.height
        }),

        right = game.sprite('right', {
            width: 1,
            height: canvas.height
        }),

        startRound = function () {
            if (ball.placed()) {
                ball.clear();
            }
            ball.place(paddle1.right + 1, 1);

            ball.xPixelsPerTick = 25;
            ball.yPixelsPerTick = 26;

            Y.one('#score_player1').setContent(state.p1score);
            Y.one('#score_player2').setContent(state.p2score);
        };

        paddle1.place(0, 0);
        paddle2.fillStyle = 'red';
        paddle2.place(
            canvas.width - paddle2.width,
            canvas.height - paddle2.height
        );

        top.place(0, 0);
        bottom.place(0, canvas.height);
        left.place(0, 0);
        right.place(canvas.width, 0);

        // events
        Y.on('arnie:pre-intersect', function () {
            paddle1.clear().move();
            paddle2.clear().move();
            ball.clear().move();
        });

        ball.on('arnie:collision', function (other) {
            switch (other) {
            case paddle1:
                ping = true;
                this.reverseX();
                this.place(other.right, this.y);
                break;
            case paddle2:
                pong = true;
                this.reverseX();
                this.place(other.left - this.width, this.y);
                break;
            case left:
                // set the ping state as undefined
                ping = undefined;
                // after 10 miliseconds check if the nothing happened,
                // only then assume that the other side didn't actually catch it
                setTimeout(function(){
                  if (ping == undefined){
                    state.p2score += 1;
                    Y.one('#score_player1').setContent(state.p1score);
                    Y.one('#score_player2').setContent(state.p2score);
                  }
                }, defaultTimeout);
                break;
            case right:
                // set the ping state as undefined
                pong = undefined;
                // after 10 miliseconds check if the nothing happened,
                // only then assume that the other side didn't actually catch it
                setTimeout(function(){
                  if (pong == undefined){
                    state.p1score += 1;
                    Y.one('#score_player1').setContent(state.p1score);
                    Y.one('#score_player2').setContent(state.p2score);
                  }
                }, defaultTimeout);
                break;
            case top:
            case bottom:
                /**
                 * lets try onesided synchronization
                 */
                // if (playerId == 1 && state.syncBlock != undefined){
                //   send_sync_bounce(this.x + this.xPixelsPerTick, this.y + this.yPixelsPerTick);
                //   stat.syncBlock = true;
                //   setTimeout(function(){
                //     state.syncBlock = undefined;
                //   }, 20);
                // }
                this.reverseY();
                break;
            }
        });

        Y.on('arnie:post-intersect', function () {
            paddle1.draw();
            paddle2.draw();
            ball.draw();
        });

        Y.on('arnie:reset', function () {
        });

        Y.on('mousemove', function (e) {
          if (playerId == 1) {
            state.currentY = e.clientY - (paddle1.height / 2);
            paddle1.setY(state.currentY);
          }
          else {
            state.currentY = e.clientY - (paddle2.height / 2);
            paddle2.setY(state.currentY);
          }
        });

        return {
            // objects used privately, also available publicly
            Y: Y,
            game: game,
            startRound: startRound,
            ball: ball,
            paddle1: paddle1,
            paddle2: paddle2,
            bottom: bottom,
            top: top,
            left: left,
            right: right
        };
    }());

    Y.on('domready', function (e) {
        Y.one(window.document).on('click', function () {
          /* only the first player in the game is allowed to launch the game */
          /* real programmers don't do this shit, fuck it... if you have any complaints
           * don't send them to me
           */
          if(playerId == 1 && state.p1score < 5 && state.p2score < 5){
            // PONG.game.reset();
            PONG.startRound();
            start_game();
          }
          else if(state.p1score == 5){
            /**
             * too tired to think of the right way. look... i know it's wrong ok?
             */
            if(playerId == 1){
              $.post('/leader_boards');
            }
            alert("Player 1 won");
          }
          else if(state.p2score == 5){
            alert("Player 2 won");
            if(playerId == 2){
              $.post('/leader_boards');
            }
          }
        });

        PONG.game.reset();
    });

});

