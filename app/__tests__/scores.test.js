const mongoose = require('mongoose');
const request = require('supertest');
const app = require('../app');

const Score = require('../models/score.model');
const scoreData = require('../db/data/scoreData');

beforeEach((done) => {
	mongoose.connect('mongodb://127.0.0.1:27017/snake_test', () => {
		const seedDB = async () => {
			await Score.deleteMany({});
			await Score.insertMany(scoreData);
		};

		seedDB().then(() => {
			done();
		});
	});
});

afterEach((done) => {
	mongoose.connection.db.dropDatabase(() => {
		mongoose.connection.close(() => done());
	});
});

const ENDPOINT = '/api/scores';

describe('Score', () => {
	describe('GET /api/scores', () => {
		it('should return a status of 200 and an array containing 1 score', () => {
			return request(app)
				.get(ENDPOINT)
				.then((res) => {
					expect(res.body.scores.length).toBe(1);
					expect(res.body.scores[0].name).toEqual('Adam');
					expect(res.body.scores[0].score).toEqual(23);
				});
		});
	});

	describe('POST /api/scores', () => {
		it('should return a status of 201 and the score that was added', () => {
			const score = {
				data: {
					name: 'Charlie',
					score: 42,
				},
			};

			return request(app)
				.post(ENDPOINT)
				.send(score)
				.expect(201)
				.then((res) => {
					expect(res.body.score).toBeInstanceOf(Object);
					expect(res.body.score.name).toEqual('Charlie');
					expect(res.body.score.score).toEqual(42);
				});
		});

		it('should return a status of of 400 when not provided with the a score', () => {
			const score = {
				data: {
					name: 'Ollie',
				},
			};

			return request(app)
				.post(ENDPOINT)
				.send(score)
				.expect(400)
				.then((res) => {
					expect(res.body.message).toEqual('missing required fields');
				});
		});

		it('should return a status of of 400 when not provided with the a name', () => {
			const score = {
				data: {
					score: 42,
				},
			};

			return request(app)
				.post(ENDPOINT)
				.send(score)
				.expect(400)
				.then((res) => {
					expect(res.body.message).toEqual('missing required fields');
				});
		});
	});
});
